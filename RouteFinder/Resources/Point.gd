class_name Point
extends Room

@export_enum("Dock", "Pickup", "Teleporter") var point_type : String
@export var point_connection : String

func printPointType():
	print(point_type)
