extends Panel

var style_box = preload("res://RouteFinder/Map/HUD/DragPanelStyleBox.tres")

var type := 1

func _get_drag_data(_at_position):
	pass


func _can_drop_data(_at_position, _data):
	# Check if we can drop 
	return true


func _drop_data(_at_position, data):
	# Clear the dragged panel and replace it with a drop spot
	data["Dragged From"].get_child(0).queue_free()
	data["Dragged From"].replace_by(createDropSpot())
	# Replace destination with dragged panel and clear drop spot
	replace_by(data["Copied Panel"])
	queue_free()


func createDropSpot() -> Panel:
	const min_size = Vector2(320, 30)
	var panel : Panel = Panel.new()
	panel.custom_minimum_size = min_size
	panel.set_script(load("res://RouteFinder/Map/HUD/DropSpot.gd"))
	return panel
