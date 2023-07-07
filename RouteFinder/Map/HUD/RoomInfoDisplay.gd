extends Tree


func setInfo(room : Room) -> void:
	clear()
	var root = create_item()
	root.set_text(0, room.room_name)
	for point in room.points:
		var child = create_item(root)
		child.set_text(0, point.point_connection)
		for connection in point.connections:
			var subchild = create_item(child)
			match connection.connection_type:
				"Door":
					subchild.set_text(0, str(connection.connection_type, " to ", connection.end.room_name))
				"Room":
					subchild.set_text(0, str("To ", connection.end.point_connection))
		child.collapsed = true


func printConnections(point : Point) -> void:
	for connection in point.connections:
		match connection.connection_type:
			"Door":
				print(connection.connection_type, "_", "From_", connection.start.room_name, "_to_", connection.end.room_name)
			"Room":
				print(connection.connection_type, "_", "From_", connection.start.point_connection, "_to_", connection.end.point_connection)
	print("\n")
