extends Control

# UI Elements
@onready var map = $MarginContainer2/MapWindow/HBoxContainer/SubViewportContainer/SubViewport/Map
@onready var map_hud = $MarginContainer2/MapWindow

# Pathfinding
var room_path = []
var room_queue = []
var rooms_visited = {}
var room_distance = {}
var time_distances = {}
var parent_rooms = {}
var worlds = {
	0 : load("res://RouteFinder/Resources/RoomData/Tallon Overworld.tres"),
	1 : load("res://RouteFinder/Resources/RoomData/Chozo Ruins.tres"),
	2 : load("res://RouteFinder/Resources/RoomData/Magmoor Caverns.tres"),
	3 : load("res://RouteFinder/Resources/RoomData/Phendrana Drifts.tres"),
	4 : load("res://RouteFinder/Resources/RoomData/Phazon Mines.tres")
}

# Map
var world_materials : Dictionary = {
	"Tallon Overworld" = preload("res://RouteFinder/Map/Materials/mat_Tallon.tres"),
	"Chozo Ruins" = preload("res://RouteFinder/Map/Materials/mat_Chozo.tres"),
	"Magmoor Caverns" = preload("res://RouteFinder/Map/Materials/mat_Magmoor.tres"),
	"Phendrana Drifts" = preload("res://RouteFinder/Map/Materials/mat_Phendrana.tres"),
	"Phazon Mines" = preload("res://RouteFinder/Map/Materials/mat_Mines.tres")
}
var mat_white : Material = preload("res://RouteFinder/Map/Materials/Mat_White.tres")
var mat_green : Material = preload("res://RouteFinder/Map/Materials/Mat_Green.tres")
var mat_cyan : Material = preload("res://RouteFinder/Map/Materials/mat_Selected.tres")
var mat_yellow : Material = preload("res://RouteFinder/Map/Materials/mat_Point.tres")
var room_meshes : Array = []


func _ready():
	createClickRoom()
	setRoomColors()


func findPath(start : Point, end : Point) -> void:
	rooms_visited[start] = true
	room_queue.append(getRoomFromName(start.room_name))
	room_distance[start.room_name] = 0
	parent_rooms[start.room_name] = null
	
	while room_queue.size() > 0:
		var current_room : Room = getRoomFromName(room_queue[0].room_name)
		var connecting = searchConnectingPoints(current_room, end)
		room_queue.pop_front()
			
		for r in connecting:
			if not r in rooms_visited:
				rooms_visited[r] = true
				room_queue.append(r)
	
	constructRoomPath(start, end)


func searchConnectingPoints(room : Room, end : Point) -> Array:
	
	var temp_room_array = []
	
	for p in room.points:
		
		room_distance[p.point_connection] = room_distance[room.room_name] + 1
		
		if not parent_rooms.has(p.point_connection):
			parent_rooms[p.point_connection] = room
		
		if not p.room_name == end.room_name:
			temp_room_array.append(getRoomFromName(p.point_connection))
		else:
			room_queue.clear()
			return []
	
	return temp_room_array


func constructRoomPath(start : Point, end : Point) -> void:
	room_path = [end]
	var previous_room = end
	
	while room_path.size() < room_distance[end.room_name]:
		var temp = parent_rooms[previous_room.room_name]
		if parent_rooms.has(temp.room_name):
			room_path.insert(0, temp)
			previous_room = temp
	
	room_path.insert(0, start)


func resetContainers():
	room_path.clear()
	room_queue.clear()
	rooms_visited.clear()
	room_distance.clear()
	parent_rooms.clear()
	room_meshes.clear()


func getRoomFromName(room_name : String) -> Room:
	for world in worlds.keys():
		for room in worlds[world].rooms:
			if room.room_name == room_name:
				return room
	print("Couldn't find room from name: ", room_name)
	return null


func getWorldFromName(world_name : String) -> World:
	match world_name:
		"Tallon Overworld":
			return worlds[0]
		"Chozo Ruins":
			return worlds[1]
		"Magmoor Caverns":
			return worlds[2]
		"Phendrana Drifts":
			return worlds[3]
		"Phazon Mines":
			return worlds[4]
		_:
			print("Unable to find world from name: ", world_name)
			return null


func highlightRoute(destinations : Array, all_rooms : Array) -> void:
	for r in all_rooms:
		var world_node = map.get_node(r.name)
		var room_node = world_node.get_node(r.room_name)
		var room_mesh = room_node.get_child(-1)
		room_meshes.append(room_mesh)
	
	for r in room_meshes:
		if getRoomFromName(r.get_parent().name) not in destinations:
			r.set_surface_override_material(0, mat_green)
		else:
			r.set_surface_override_material(0, mat_yellow)
	
	showElevatorDirection(all_rooms)
	map_hud.elevator_manager.setIndicators(all_rooms)
	getTimeDistance(all_rooms, all_rooms[0].points[map_hud.option_start.selected], all_rooms[-1].points[map_hud.option_end.selected])
	map_hud.setRoomsTree(time_distances)


func setRoomColors() -> void:
	for world in map.get_children():
		if world.name == "ElevatorManager":
			return
		for room in world.get_children():
			var room_mesh = room.get_child(-1)
			room_mesh.set_surface_override_material(0, world_materials[world.name])


func createClickRoom() -> void:
	for world in map.get_children():
		if world.name == "ElevatorManager":
			return
		for room in world.get_children():
			var room_mesh : MeshInstance3D = room.get_child(-1)
			room_mesh.create_convex_collision()


func roomClicked(rooms : Array) -> void:
	for room in rooms:
		highlightSelectedRoom(room)
		if not map_hud.doesPanelExist(room.get_parent().name):
			var panel : Panel = map_hud.createNewPanel(getRoomFromName(room.get_parent().name), room)
			map_hud.addPanel(panel)
	roomsArranged()


func highlightSelectedRoom(room_mesh : MeshInstance3D) -> void:
	room_mesh.set_surface_override_material(0, mat_cyan)


func roomsArranged():
	var destinations : Array = []
	for room in map_hud.room_panels.get_children():
		var room_obj = getRoomFromName(room.get_child(0).get_text())
		room.add_theme_stylebox_override("panel", map_hud.panel_colors[room_obj.name])
		destinations.append(room_obj)
	setRoomColors()
	if len(destinations) > 1:
		map_hud.showStartEndPoints(destinations[0], destinations[-1])
		displayRoute(destinations)
	elif len(destinations) == 1:
		for world in map.get_children():
			for room in world.get_children():
				if room.name == destinations[0].room_name:
					highlightSelectedRoom(room.get_child(-1))
		stopElevatorIndicator()
		map_hud.clearStartEndPoints()
	elif len(destinations) == 0:
		stopElevatorIndicator()
		map_hud.clearStartEndPoints()
		return


func displayRoute(destinations : Array) -> void:
	resetContainers()
	var master_path = []
	for i in range(0, len(destinations)):
		
		# If route only has two destinations
		if i == 0 and i + 1 == len(destinations):
			findPath(destinations[i].points[map_hud.option_start.selected], destinations[i + 1].points[map_hud.option_end.selected])
			highlightRoute(destinations, master_path)
			return
		# If first room in the route and len destinations > 2
		elif i == 0:
			findPath(destinations[i].points[map_hud.option_start.selected], destinations[i + 1].points[0])
		# If done pathfinding
		elif i + 1 == len(destinations):
			highlightRoute(destinations, master_path)
			return
		else:
			findPath(destinations[i].points[0], destinations[i + 1].points[0])
		
		for room in room_path:
			master_path.append(getRoomFromName(room.room_name))
		
		resetContainers()


func roomRemoved(room_name : String):
	for world in map.get_children():
		for room in world.get_children():
			if room.name == room_name:
				print("Removing ", room_name)
				map_hud.removeRoom(room.get_child(-1))


func showElevatorDirection(all_rooms : Array) -> void:
	map_hud.elevator_manager.setIndicators(all_rooms)


func stopElevatorIndicator() -> void:
	map_hud.elevator_manager.stopIndicators()


func _on_map_window_room_info_displayed(room_name):
	map_hud.makeRoomInfoDisplay(getRoomFromName(room_name))


func getTimeDistance(path : Array, start : Point, end : Point) -> void:
	time_distances.clear()
	var rooms = []
	var times = {}
	var tag = "Default"
	# Get tag from line edit if there is one
	if not map_hud.tag_line_edit.get_text().is_empty():
		tag = map_hud.tag_line_edit.get_text()
	
	for i in range(0, len(path)):
		
		# If first room
		if i == 0:
			for connection in start.connections:
				if connection.end.point_connection == path[i + 1].room_name:
					if connection.times.has(tag):
						rooms.append(start.room_name)
						times[start.room_name] = connection.times[tag]
						break
					else:
						rooms.append(start.room_name)
						times[start.room_name] = connection.times["Default"]
						break
		
		# If last room
		elif i == len(path) - 1:
			for point in path[i].points:
				if point.point_connection == path[i - 1].room_name:
					for connection in point.connections:
						if connection.end.point_connection == end.point_connection:
							if connection.times.has(tag):
								rooms.append(end.room_name)
								times[end.room_name] = connection.times[tag]
								break
							else:
								rooms.append(end.room_name)
								times[end.room_name] = connection.times["Default"]
								break
		
		# In between rooms
		else:
			for point in path[i].points:
				if point.point_connection == path[i - 1].room_name:
					for connection in point.connections:
						if connection.end.point_connection == path[i + 1].room_name:
							if connection.times.has(tag):
								rooms.append(path[i].room_name)
								times[path[i].room_name] = connection.times[tag]
								break
							else:
								rooms.append(path[i].room_name)
								times[path[i].room_name] = connection.times["Default"]
								break
	
	time_distances[rooms] = times


func _on_map_window_cleared():
	stopElevatorIndicator()
	map_hud.clearStartEndPoints()
	for child in map_hud.room_panels.get_children():
		child.queue_free()
	roomsArranged()
