extends Control
signal room_clicked(room_array : Array)
signal room_removed(room_name : String)
signal rooms_arranged

############################ TO DO #####################################
# 
########################################################################

@onready var map = $HBoxContainer/SubViewportContainer/SubViewport/Map
@onready var camera = $HBoxContainer/SubViewportContainer/SubViewport/Camera3D
@onready var subviewport = $HBoxContainer/SubViewportContainer/SubViewport
@onready var room_panels = $HBoxContainer/Panel/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer

var selected_rooms : Array = []
var kill_callable := Callable(self, "removeRoom")


func _input(_event):
	if is_visible_in_tree():
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


func createNewPanel(room_name : String, room_mesh : MeshInstance3D) -> Panel:
	var min_size = Vector2(320, 30)
	
	var label : Label = Label.new()
	label.set_text(room_name)
	label.custom_minimum_size = min_size
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	var panel : Panel = Panel.new()
	panel.custom_minimum_size = min_size
	panel.add_theme_stylebox_override("panel", load("res://RouteFinder/Map/HUD/DragPanelStyleBox.tres"))
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
	print("Running removeRoom")
	if selected_rooms.has(room_mesh):
		selected_rooms.erase(room_mesh)
		emit_signal("rooms_arranged")
		return
	print("Couldn't find room in selected_rooms")
