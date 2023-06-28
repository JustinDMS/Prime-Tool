extends Control

@onready var tallon = load("res://RouteFinder/Resources/RoomData/Tallon Overworld.tres")
@onready var chozo = load("res://RouteFinder/Resources/RoomData/Chozo Ruins.tres")
@onready var magmoor = load("res://RouteFinder/Resources/RoomData/Magmoor Caverns.tres")
@onready var phendrana = load("res://RouteFinder/Resources/RoomData/Phendrana Drifts.tres")
@onready var mines = load("res://RouteFinder/Resources/RoomData/Phazon Mines.tres")

const json_path : String = "res://RoomData.json"
const room_save_path : String = ""
const world_save_path : String = "res://RouteFinder/Resources/RoomData/"

var data


func _ready():
	pass
	#readJSON()
	#addRoomsToWorld()


func readJSON() -> void:
	var file = FileAccess.open(json_path, FileAccess.READ)
	var file_as_text = file.get_as_text()
	var test_json_conv = JSON.new()
	test_json_conv.parse(file_as_text)
	data = test_json_conv.get_data()


func addRoomsToWorld(world : World) -> void:
	for r in data["World"][world.name]: 									# For every room in world:
		var new_room : Room = createRoom(world, r) 								# Create room
		for c in data["World"][world.name][r].keys(): 							# For every connecting room:
			var new_point : Point = createPoint(world, new_room, "Dock", c) 		# Create point
			new_room.points.append(new_point) 										# Add point to room
		saveRoomResource(new_room) 												# Save room to file
		world.rooms.append(new_room) 											# Add room to world
	saveWorldResource(world) 												# Save world to file


func createRoom(world : World, room_name : String) -> Room:
	var new_room = Room.new()
	new_room.name = world.name
	new_room.room_name = room_name
	return new_room


func createPoint(world : World, room : Room, point_type : String, connecting_room : String,) -> Point:
	var new_point = Point.new()
	new_point.name = world.name
	new_point.room_name = room.room_name
	new_point.point_type = point_type
	new_point.point_connection = connecting_room
	return new_point


func saveRoomResource(room : Room) -> void:
	var error = ResourceSaver.save(room, room_save_path + room.room_name + ".tres")
	if error != OK:
		print("Room resource save failed! // Error: ", error)


func saveWorldResource(world : World) -> void:
	var error = ResourceSaver.save(world, world_save_path + world.name + ".tres")
	if error != OK:
		print("World resource save failed! // Error: ", error)


func distributeData(_world : World) -> void:
	pass
