extends Node


# This script is used to perform changes to World, Room, Point, or Connection resources 


@onready var tallon = load("res://RouteFinder/Resources/RoomData/Tallon Overworld.tres")
@onready var chozo = load("res://RouteFinder/Resources/RoomData/Chozo Ruins.tres")
@onready var magmoor = load("res://RouteFinder/Resources/RoomData/Magmoor Caverns.tres")
@onready var phendrana = load("res://RouteFinder/Resources/RoomData/Phendrana Drifts.tres")
@onready var mines = load("res://RouteFinder/Resources/RoomData/Phazon Mines.tres")
@onready var worlds = {
	0 : tallon,
	1 : chozo,
	2 : magmoor,
	3 : phendrana,
	4 : mines
}

const room_save_path : String = ""
const world_save_path : String = "res://RouteFinder/Resources/RoomData/"

const tallon_path : String = "res://RouteFinder/Resources/RoomData/1 - Tallon/"
const chozo_path : String = "res://RouteFinder/Resources/RoomData/2 - Chozo/"
const magmoor_path : String = "res://RouteFinder/Resources/RoomData/3 - Magmoor/"
const phendrana_path : String = "res://RouteFinder/Resources/RoomData/4 - Phendrana/"
const mines_path : String = "res://RouteFinder/Resources/RoomData/5 - Mines/"

var paths = {
	"Tallon Overworld" : tallon_path,
	"Chozo Ruins" : chozo_path,
	"Magmoor Caverns" : magmoor_path,
	"Phendrana Drifts" : phendrana_path,
	"Phazon Mines" : mines_path
}

var data


func _ready():
	pass


func saveConnectionResource(connection : Connection, path : String):
	match connection.connection_type:
		"Room": # Internal
			var error = ResourceSaver.save(connection, path + connection.connection_type + "_" + connection.start.point_connection + "_to_" + connection.end.point_connection + ".tres")
			if error != OK:
				print("Connection resource save failed! // Error: ", error)
		"Door": # External
			var error = ResourceSaver.save(connection, path + connection.connection_type + "_" + connection.start.room_name + "_to_" + connection.end.room_name + ".tres")
			if error != OK:
				print("Connection resource save failed! // Error: ", error)


func createInternalConnection(start : Point, end : Point) -> Connection:
	var new_connection = Connection.new()
	new_connection.start = start
	new_connection.end = end
	new_connection.room_name = start.room_name
	new_connection.name = start.name
	new_connection.point_type = start.point_type
	new_connection.point_connection = end.room_name
	return new_connection

# Set Point Type
func createExternalConnection(start : Point) -> Connection:
	var new_connection = Connection.new()
	new_connection.connection_type = "Door"
	new_connection.start = start
	new_connection.room_name = start.room_name
	new_connection.name = start.name
	new_connection.point_type = start.point_type
	for id in worlds.keys():
		for room in worlds[id].rooms:
			if room.room_name == start.point_connection:
				for point in room.points:
					if point.point_connection == start.room_name:
						new_connection.end = point
						new_connection.point_connection = point.room_name
						return new_connection
	return null


func getRoomFromName(room_name : String) -> Room:
	for world in worlds.keys():
		for room in worlds[world].rooms:
			if room.room_name == room_name:
				return room
	print("Couldn't find room from name: ", room_name)
	return null


func buildWorldResource(object : Object):
	var new_world := World.new()
	new_world.name = object.name
	new_world.meshes = object.meshes
	for room in object.rooms:
		var new_room := Room.new()
		new_room.name = object.name
		new_room.room_name = room.room_name
		print(new_room.room_name)
		var temp : Dictionary = getConnections(getRoomFromName(new_room.room_name))
		for point in temp.keys():
			var new_point := Point.new()
			new_point.name = new_room.name
			new_point.room_name = new_room.room_name
			new_point.point_type = point.point_type
			new_point.point_connection = point.point_connection
			new_point.connections = temp[point]
			new_room.points.append(new_point)
		new_world.rooms.append(new_room)
	ResourceSaver.save(new_world, "res://RouteFinder/Resources/RoomData/" + new_world.name + ".tres")


func getConnections(room : Room) -> Dictionary:
	var connections : Dictionary = {}
	for i in range(0, len(room.points)):
		connections[room.points[i]] = []
		
		# Find external connections ie connections between points in different rooms
		var new_ext_connection : Connection = createExternalConnection(room.points[i])
		
		# If there is an external connection/connection is not one way
		if new_ext_connection:
			connections[room.points[i]].append(new_ext_connection)
		
		# Exit loop if room doesn't have additional points
		if not len(room.points) > 1:
			continue
		
		# Find all internal connections ie connections between points in the same room
		for c in range(0, len(room.points)):
			# Continue to next iteration if indices (aka points) are the same
			if room.points[i] == room.points[c]:
				continue
			var new_int_connection : Connection = createInternalConnection(room.points[i], room.points[c])
			connections[room.points[i]].append(new_int_connection)
	
	return connections
