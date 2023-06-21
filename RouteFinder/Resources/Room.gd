class_name Room
extends World

@export var room_name : String
@export var points : Array # Should contain only Point objects


func printRoomName():
	print(room_name)


func printAllPoints():
	for p in points:
		print(p)
