extends Tree
signal connection_clicked(connection : Connection)

var connection_items := {}


func _ready():
	set_column_clip_content(0, false)
	set_column_expand(0, true)


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
	connection_items[subchild] = connection
	
	match connection.connection_type:
		"Door":
			subchild.visible = false
			#subchild.set_text(0, str(connection.connection_type, " to ", connection.end.room_name))
			#subchild.collapsed = true
		"Room":
			subchild.set_text(0, str("To ", connection.end.point_connection))


func _on_cell_selected():
	var selected_item = get_selected()
	if connection_items.keys().has(selected_item):
		if connection_items[selected_item].connection_type == "Room":
			emit_signal("connection_clicked", connection_items[selected_item])
