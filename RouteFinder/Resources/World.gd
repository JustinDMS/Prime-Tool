class_name World
extends Resource

@export_enum("Tallon Overworld", "Chozo Ruins", "Magmoor Caverns", "Phendrana Drifts", "Phazon Mines") var name : String
@export var rooms : Array # Should contain only Room objects
@export var meshes : PackedScene


func printWorld():
	print(name)


func printAllRooms():
	for r in rooms:
		print(r)
