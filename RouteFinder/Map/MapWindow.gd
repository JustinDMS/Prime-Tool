extends Control
signal room_clicked(room_array : Array)
signal room_removed(room_name : String)
signal rooms_arranged
signal room_info_displayed(room_name : String)
signal cleared

@onready var map = $HBoxContainer/SubViewportContainer/SubViewport/Map
@onready var camera = $HBoxContainer/SubViewportContainer/SubViewport/Camera3D
@onready var subviewport = $HBoxContainer/SubViewportContainer/SubViewport
@onready var room_panels = $HBoxContainer/Panel/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
@onready var elevator_manager = $HBoxContainer/SubViewportContainer/SubViewport/Map/ElevatorManager
@onready var room_info_display = $HBoxContainer/Panel2/MarginContainer/VBoxContainer/RoomInfoDisplay
@onready var connection_container = $HBoxContainer/Panel2/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
@onready var option_start = $HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/Option_Start
@onready var option_end = $HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer2/Option_End
@onready var room_label = $HBoxContainer/Panel2/MarginContainer/VBoxContainer/HBoxContainer2/Label_Room
@onready var tag_line_edit = $HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer3/LineEdit_Tag
@onready var room_tree = $HBoxContainer/Panel/MarginContainer/VBoxContainer/Tree_Rooms
@onready var room_count_label = $HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer4/VBoxContainer/Label_RoomCount
@onready var route_time_label = $HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer4/VBoxContainer/Label_RouteTime
@onready var button_copy = $HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer4/VBoxContainer2/Button_Copy
@onready var button_clear = $HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer4/VBoxContainer2/Button_Clear


var panel_colors = {
	"Tallon Overworld" = load("res://RouteFinder/Map/HUD/StyleBox_Tallon.tres"),
	"Chozo Ruins" = load("res://RouteFinder/Map/HUD/StyleBox_Chozo.tres"),
	"Magmoor Caverns" = load("res://RouteFinder/Map/HUD/StyleBox_Magmoor.tres"),
	"Phendrana Drifts" = load("res://RouteFinder/Map/HUD/StyleBox_Phendrana.tres"),
	"Phazon Mines" = load("res://RouteFinder/Map/HUD/StyleBox_Mines.tres")
}
var selected_rooms : Array = []
var kill_callable := Callable(self, "removeRoom")
var previous_start_room : Room
var previous_end_room : Room


func _input(_event):
	if is_visible_in_tree():
		if Input.is_action_just_pressed("room_info_select"):
			var clicked_room = getRoomMeshFromClick()
			if clicked_room:
				emit_signal("room_info_displayed", clicked_room.get_parent().name)
			return
		if Input.is_action_just_pressed("left_click"):
			var clicked_room = getRoomMeshFromClick()
			if clicked_room:
				if clicked_room not in selected_rooms:
					selected_rooms.append(clicked_room)
					emit_signal("room_clicked", selected_rooms)


func getRoomMeshFromClick() -> MeshInstance3D:
	var mouse_pos = subviewport.get_mouse_position()
	if mouse_pos.x < 0:
		return null
	var ray_length = 5000
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = camera.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	if raycast_result:
		return raycast_result.collider.get_parent()
	return null


func createNewPanel(room : Room, room_mesh : MeshInstance3D) -> Panel:
	var min_size = Vector2(320, 30)
	
	var label : Label = Label.new()
	label.set_text(room.room_name)
	label.custom_minimum_size = min_size
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_color_override("font_color", Color.BLACK)
	
	var panel : Panel = Panel.new()
	panel.custom_minimum_size = min_size
	panel.add_theme_stylebox_override("panel", panel_colors[room.name])
	panel.mouse_default_cursor_shape = Control.CURSOR_DRAG
	panel.set_script(load("res://RouteFinder/Map/HUD/RoomNamePanel.gd"))
	panel.tree_exited.connect(kill_callable.bind(room_mesh))
	panel.mesh = room_mesh
	
	panel.add_child(label)
	
	return panel


func addPanel(panel : Panel) -> void:
	room_panels.add_child(panel)


func doesPanelExist(room_name : String) -> bool:
	for p in room_panels.get_children():
		if room_name == p.get_child(0).get_text():
			return true
	return false


func removeRoom(room_mesh : MeshInstance3D) -> void:
	if selected_rooms.has(room_mesh):
		selected_rooms.erase(room_mesh)
		emit_signal("rooms_arranged")
		return
	print("Couldn't find room in selected_rooms")


func makeRoomInfoDisplay(room : Room) -> void:
	room_info_display.setInfo(room)


func _on_room_info_display_connection_clicked(connection):
	room_label.set_text(connection.start.point_connection + " to " + connection.end.point_connection)
	for child in connection_container.get_children():
		child.queue_free()
	for tag in connection.times.keys():
		var new_editor = load("res://RouteFinder/Map/HUD/ConnectionEditor.tscn").instantiate()
		connection_container.add_child(new_editor)
		new_editor.setInfo(tag, connection.times[tag], connection)


func _on_button_add_pressed():
	var new_editor = load("res://RouteFinder/Map/HUD/ConnectionEditor.tscn").instantiate()
	connection_container.add_child(new_editor)


func _on_button_save_pressed():
	var default = connection_container.get_child(0)
	var world : World = default.world
	var room_idx : int = world.rooms.find(default.room)
	var point_idx : int = world.rooms[room_idx].points.find(default.point)
	var connection_idx : int = world.rooms[room_idx].points[point_idx].connections.find(default.connection)
	var new_connection_data = {}
	for child in connection_container.get_children():
		if child == default:
			new_connection_data["Default"] = child.default_time
			continue
		if not child.tag_edit.get_text().is_empty() and child.time_edit.get_text().is_valid_float():
			new_connection_data[child.tag_edit.get_text()] = float(child.time_edit.get_text())
			continue
		else:
			print("Invalid connection, skipping")
			continue
	
	world.rooms[room_idx].points[point_idx].connections[connection_idx].times = new_connection_data
	var _error = ResourceSaver.save(world, default.save_path)


func clearStartEndPoints() -> void:
	option_start.clear()
	option_end.clear()


func showStartEndPoints(start : Room, end : Room) -> void:
	
	if not previous_start_room == start:
		option_start.clear()
		for point in start.points:
			option_start.add_item("Door to " + point.point_connection)
		previous_start_room = start
	if not previous_end_room == end:
		option_end.clear()
		for point in end.points:
			option_end.add_item("Door to " + point.point_connection)
		previous_end_room = end


func pointOptionSelected(_index):
	emit_signal("rooms_arranged")


func _on_line_edit_tag_text_submitted(_new_text):
	emit_signal("rooms_arranged")


func setRoomsTree(paths : Dictionary) -> void:
	room_tree.clear()
	room_tree.set_column_clip_content(0, true)
	room_tree.set_column_expand(0, true)
	room_tree.set_column_expand(1, false)
	room_tree.set_column_custom_minimum_width(1, 75)
	
	var total_time := 0.0
	var room_count := 0
	
	var root = room_tree.create_item()
	for key in paths.keys():
		for room in key:
			var child = room_tree.create_item(root)
			child.set_text(0, room)
			child.set_text(1, str(paths[key][room]))
			total_time += paths[key][room]
			room_count += 1
	
	setRoomCount(room_count)
	setRouteTime(total_time)


func setRoomCount(count : int) -> void:
	room_count_label.set_text(str(count))


func setRouteTime(time : float) -> void:
	route_time_label.set_text(str(time) + "s")


func _on_button_copy_pressed():
	if not button_copy.is_hovered():
		return
	if room_tree.get_root():
		var children = room_tree.get_root().get_children()
		var text = ""
		for i in range(0, len(children)):
			if i == len(children) - 1:
				text += children[i].get_text(0)
				DisplayServer.clipboard_set(text)
				return
			text += children[i].get_text(0) + "\n"


func _on_button_clear_pressed():
	if not button_clear.is_hovered():
		return
	emit_signal("cleared")
	room_tree.clear()
	setRoomCount(0)
	setRouteTime(0)
	previous_start_room = null
	previous_end_room = null


func _on_button_show_controls_pressed():
	var new_window = load("res://RouteFinder/Map/HUD/MapControls.tscn").instantiate()
	add_child(new_window)
	new_window.close_requested.connect(Callable(new_window, "queue_free"))
	new_window.popup()
