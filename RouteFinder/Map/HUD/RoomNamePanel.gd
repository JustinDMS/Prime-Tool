extends Panel

var is_hovering := false
var map_window
var mesh : MeshInstance3D

const min_size = Vector2(320, 30)


func _ready():
	map_window = find_parent("MapWindow")
	mouse_entered.connect(Callable(self, "mouseHover"))
	mouse_exited.connect(Callable(self, "mouseUnhover"))


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.double_click and is_hovering:
			queue_free()


func _get_drag_data(_at_position):
	# Retrieve information about what we're dragging
	var data = {}
	data["Kill Callable"] = map_window.rooms_arranged.get_connections()[0]["callable"]
	data["Label"] = get_child(0)
	data["Style Box"] = get_theme_stylebox("panel")
	data["Position"] = _at_position
	var drag_preview : Control = createCopy(data)
	set_drag_preview(drag_preview)
	
	return data


func _can_drop_data(_at_position, _data):
	return true


func _drop_data(_at_position, data):
	# If attempting to drop on self
	if self == data["Dragged From"]:
		return
	# This is what runs if you drag one room over another
	# Swap information with self
	data["Dragged From"].get_child(0).set_text(get_child(0).get_text())
	# Clear the destination and replace with dragged panel
	get_child(0).queue_free()
	replace_by(data["Copied Panel"])
	# Tell the Route Finder that we changed the order of the rooms and to find the new route
	data["Copied Panel"].tree_exited.connect(data["Kill Callable"])


func createCopy(data) -> Control:
	
	var label : Label = Label.new()
	label.set_text(get_child(0).get_text())
	label.custom_minimum_size = min_size
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_color_override("font_color", Color.BLACK)
	
	var panel : Panel = Panel.new()
	panel.custom_minimum_size = min_size
	panel.add_theme_stylebox_override("panel", data["Style Box"])
	panel.mouse_default_cursor_shape = Control.CURSOR_DRAG
	panel.set_script(load("res://RouteFinder/Map/HUD/RoomNamePanel.gd"))
	panel.tree_exited.connect(data["Kill Callable"])
	panel.add_child(label)
	
	var control = Control.new()
	control.add_child(panel)
	panel.set_position(-0.5 * min_size)
	
	data["Copied Panel"] = panel.duplicate()
	data["Dragged From"] = self
	data["MapWindow"] = map_window
	data["Kill Callable"] = data["Kill Callable"]
	
	return control


func mouseHover():
	is_hovering = true


func mouseUnhover():
	is_hovering = false
