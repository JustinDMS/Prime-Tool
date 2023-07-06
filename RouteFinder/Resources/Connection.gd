class_name Connection
extends Point

@export_enum("Room", "Door") var connection_type : String = "Room"
@export var start : Point
@export var end : Point
@export var times : Dictionary = {"Default" : 10.0,}
@export var logic : Array
