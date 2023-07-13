extends Control

@onready var tag_edit = $Hbox/TagEdit
@onready var time_edit = $Hbox/TimeEdit
@onready var button = $Hbox/Button

const default_time : float = 10.0

var world : World
var room : Room
var point : Point
var connection : Connection
var save_path : String


func setInfo(tag : String, time : float, _connection : Connection) -> void:
	tag_edit.set_text(tag)
	time_edit.set_text(str(time))
	# Save the connection that's being edited so we can save it to the world resource
	connection = _connection
	getConnectionInfo()


func getConnectionInfo() -> void:
	# World
	match connection.name:
		"Tallon Overworld":
			save_path = "res://RouteFinder/Resources/RoomData/Tallon Overworld.tres"
		"Chozo Ruins":
			save_path = "res://RouteFinder/Resources/RoomData/Chozo Ruins.tres"
		"Magmoor Caverns":
			save_path = "res://RouteFinder/Resources/RoomData/Magmoor Caverns.tres"
		"Phendrana Drifts":
			save_path = "res://RouteFinder/Resources/RoomData/Phendrana Drifts.tres"
		"Phazon Mines":
			save_path = "res://RouteFinder/Resources/RoomData/Phazon Mines.tres"
		_:
			print("Unknown world for connection")
			return
	world = load(save_path)
	
	# Room
	for r in world.rooms:
		if r.room_name == connection.start.room_name:
			room = r
			break
	
	# Point
	for p in room.points:
		if p.point_connection == connection.start.point_connection:
			point = p
			break


func _on_button_pressed():
	queue_free()
