extends Tree


func _ready():
	set_column_clip_content(0, true)
	set_column_clip_content(1, false)
	set_column_expand(0, true)
	set_column_expand(1, false)
	set_column_custom_minimum_width(1, 75)


func setInfo(room : Room) -> void:
	clear()
	var root = create_item()
	root.set_text(0, room.room_name)
	root.disable_folding = true
	for point in room.points:
		var child = makeNewPointItem(root, point)
		for connection in point.connections:
			makeNewConnectionItem(child, connection)


func makeNewPointItem(root : TreeItem, point : Point) -> TreeItem:
	var child = create_item(root)
	child.collapsed = true
	child.set_text(0, point.point_connection)
	return child


func makeNewConnectionItem(root : TreeItem, connection : Connection) -> void:
	var subchild = create_item(root)
	subchild.collapsed = true
	match connection.connection_type:
		"Door":
			subchild.set_text(0, str(connection.connection_type, " to ", connection.end.room_name))
			subchild.collapsed = true
		"Room":
			subchild.set_text(0, str("To ", connection.end.point_connection))
			for time in connection.times.keys():
				var time_child = create_item(subchild)
				time_child.set_text(0, time)
				time_child.set_text(1, str(connection.times[time]))
				time_child.set_editable(1, true)
	
