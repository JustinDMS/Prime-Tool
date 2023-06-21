extends Control

############################ TO DO #####################################
# Show direction of elevators
########################################################################

# UI Elements
@onready var option_room_1 = $MarginContainer/VBoxContainer/VBoxContainer_A/Option_Room1
@onready var option_room_2 = $MarginContainer/VBoxContainer/VBoxContainer_B/Option_Room2
@onready var option_world_1 = $MarginContainer/VBoxContainer/VBoxContainer_A/Option_World1
@onready var option_world_2 = $MarginContainer/VBoxContainer/VBoxContainer_B/Option_World2
@onready var option_point_1 = $MarginContainer/VBoxContainer/VBoxContainer_A/Option_Point1
@onready var option_point_2 = $MarginContainer/VBoxContainer/VBoxContainer_B/Option_Point2
@onready var copy_button = $MarginContainer/VBoxContainer/HBoxContainer/Button_CopyText
@onready var item_list = $MarginContainer/VBoxContainer/Result_ItemList

# Pathfinding
enum point {POINT_A, POINT_B}
var room_path = []
var room_queue = []
var rooms_visited = {}
var distance = {}
var parent_rooms = {}
var worlds = {
	0 : load("res://RouteFinder/Resources/RoomData/Tallon Overworld.tres"),
	1 : load("res://RouteFinder/Resources/RoomData/Chozo Ruins.tres"),
	2 : load("res://RouteFinder/Resources/RoomData/Magmoor Caverns.tres"),
	3 : load("res://RouteFinder/Resources/RoomData/Phendrana Drifts.tres"),
	4 : load("res://RouteFinder/Resources/RoomData/Phazon Mines.tres")
}

# Etc
var window_size := Vector2(550, 650)

# Map
var map_scene
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
var clicked_room


func _ready():
	buildRoomList(worlds[0], point.POINT_A)
	buildRoomList(worlds[1], point.POINT_B)
	buildPointList(worlds[0].rooms[0], point.POINT_A)
	buildPointList(worlds[1].rooms[0], point.POINT_B)


func displayResults(end : Point) -> void:
	for r in room_path:
		item_list.add_item(r.room_name)
	
	copy_button.set_text("Copy " + str(distance[end.room_name] + 1) + " rooms")


func buildRoomList(world : World, route_point : point) -> void:
	
	var options_node
	
	if route_point == 0: # Point A
		options_node = option_room_1
	elif route_point == 1: # Point B
		options_node = option_room_2
	
	options_node.clear()
	
	for i in world.rooms:
		options_node.add_item(i.room_name)


func buildPointList(room : Room, route_point : point) -> void:
	
	var options_node
	
	if route_point == 0: # Point A
		options_node = option_point_1
	elif route_point == 1: # Point B
		options_node = option_point_2
	
	options_node.clear()
	
	for i in room.points:
		options_node.add_item("Door to " + i.point_connection)


func findPath(start : Point, end : Point) -> void:
	rooms_visited[start] = true
	room_queue.append(getRoomFromName(start.room_name))
	distance[start.room_name] = 0
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
		
		distance[p.point_connection] = distance[room.room_name] + 1
		
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
	
	while room_path.size() < distance[end.room_name]:
		var temp = parent_rooms[previous_room.room_name]
		if parent_rooms.has(temp.room_name):
			room_path.insert(0, temp)
			previous_room = temp
	
	room_path.insert(0, start)
	
	if getMapOpen(): 
		highlightRoute()
	
	displayResults(end)


func resetContainers():
	room_path.clear()
	room_queue.clear()
	rooms_visited.clear()
	distance.clear()
	parent_rooms.clear()
	room_meshes.clear()
	
	item_list.clear()
	copy_button.set_text("Copy")
	
	if getMapOpen():
		clearHighlights()


func _on_Option_World1_item_selected(index):
	buildRoomList(worlds[index], point.POINT_A)
	buildPointList(worlds[index].rooms[0], point.POINT_A)


func _on_Option_World2_item_selected(index):
	buildRoomList(worlds[index], point.POINT_B)
	buildPointList(worlds[index].rooms[0], point.POINT_B)


func _on_Button_GetRooms_pressed():
	var start : Point = worlds[option_world_1.get_selected_id()].rooms[option_room_1.get_selected_id()].points[option_point_1.get_selected_id()]
	var end : Point = worlds[option_world_2.get_selected_id()].rooms[option_room_2.get_selected_id()].points[option_point_2.get_selected_id()]
	
	if start == end:
		pass
	else:
		resetContainers()
		findPath(start, end)


func _on_Button_CopyText_pressed():
	var text := ""
	for r in room_path:
		text += r.room_name
		if r != room_path[-1]:
			text += "\n"
	DisplayServer.clipboard_set(text)


func _on_Button_Clear_pressed():
	resetContainers()


func _on_option_room_1_item_selected(index):
	buildPointList(worlds[option_world_1.get_selected_id()].rooms[index], point.POINT_A)


func _on_option_room_2_item_selected(index):
	buildPointList(worlds[option_world_2.get_selected_id()].rooms[index], point.POINT_B)


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


func _on_button_open_map_pressed():
	if not getMapOpen():
		var new_scene = load("res://RouteFinder/Map/MapWindow.tscn").instantiate()
		map_scene = new_scene
		get_parent().add_child(map_scene)
		map_scene.room_clicked.connect(roomClicked)
		createClickRoom()
		setRoomColors()
		map_scene.popup()


func getMapOpen() -> bool:
	if is_instance_valid(map_scene):
		return true
	return false


func highlightRoute() -> void:
	for r in room_path:
		var world_node = map_scene.map.get_node(r.name)
		var room_node = world_node.get_node(r.room_name)
		var room_mesh = room_node.get_child(-1)
		room_meshes.append(room_mesh)
	
	for r in room_meshes:
		r.set_surface_override_material(0, mat_green)
	
	room_meshes[0].set_surface_override_material(0, mat_yellow)
	room_meshes[-1].set_surface_override_material(0, mat_yellow)


func clearHighlights() -> void:
	for r in room_meshes:
		r.set_surface_override_material(0, mat_white)
	room_meshes.clear()
	setRoomColors()


func setRoomColors() -> void:
	for world in map_scene.map.get_children():
		for room in world.get_children():
			var room_mesh = room.get_child(-1)
			room_mesh.set_surface_override_material(0, world_materials[world.name])


func createClickRoom() -> void:
	for world in map_scene.map.get_children():
		for room in world.get_children():
			var room_mesh : MeshInstance3D = room.get_child(-1)
			room_mesh.create_convex_collision()


func roomClicked(room : Node3D) -> void:
	if clicked_room:
		if clicked_room.get_child(-1) in room_meshes:
			if room_meshes[0] == clicked_room.get_child(-1) or room_meshes[-1] == clicked_room.get_child(-1):
				clicked_room.get_child(-1).set_surface_override_material(0, mat_yellow)
			else:
				clicked_room.get_child(-1).set_surface_override_material(0, mat_green)
		else:
			clicked_room.get_child(-1).set_surface_override_material(0, world_materials[clicked_room.get_parent().name])
	clicked_room = room
	clicked_room.get_child(-1).set_surface_override_material(0, mat_cyan)
