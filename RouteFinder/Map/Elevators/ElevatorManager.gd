extends Node3D

@onready var timer = $Timer
@onready var all_paths = [
	$ChozoWest_TallonNorth,
	$ChozoEast_TallonEast,
	$ChozoNorth_MagmoorNorth,
	$ChozoSouth_TallonSouth,
	$TallonSouth_MinesEast,
	$TallonWest_MagmoorEast,
	$MagmoorSouth_MinesWest,
	$MagmoorWest_PhendranaNorth,
	$MagmoorSouth_PhendranaSouth
]
@onready var indicator : PackedScene = load("res://RouteFinder/Map/Elevators/IndicatorMesh.tscn")

const wait_time : float = 1.5
const delay : float = 0.1

enum start_side {A, B}

var counts : Dictionary = {
	"ChozoWest_TallonNorth" : 10,
	"ChozoEast_TallonEast" : 5,
	"ChozoNorth_MagmoorNorth" : 20,
	"ChozoSouth_TallonSouth": 10,
	"TallonSouth_MinesEast" : 10,
	"TallonWest_MagmoorEast" : 5,
	"MagmoorSouth_MinesWest" : 10,
	"MagmoorWest_PhendranaNorth" : 20,
	"MagmoorSouth_PhendranaSouth" : 20
}
var elevator_info : Dictionary



func _ready():
	pass


func setIndicators(room_path : Array) -> void:
	elevator_info.clear()
	var used_elevators : Array = []
	for room in room_path:
		for point in room.points:
			if point.point_type.match("Teleporter"):
				used_elevators.append(point)
				if len(used_elevators) == 2:
					var elevator_path : Array = getElevatorPath(used_elevators)
					elevator_info[elevator_path[0]] = elevator_path[1]
					used_elevators.clear()
	timer.wait_time = wait_time
	setPathVisibility()
	makeIndicators()


func getElevatorPath(points : Array) -> Array:
	var path : Path3D
	var side : start_side
	match points[0].room_name:
		"Transport to Chozo Ruins West":
			path = $ChozoWest_TallonNorth
			side = start_side.B
		"Transport to Chozo Ruins East":
			path = $ChozoEast_TallonEast
			side = start_side.B
		"Transport to Chozo Ruins North":
			path = $ChozoNorth_MagmoorNorth
			side = start_side.B
		"Transport to Chozo Ruins South":
			path = $ChozoSouth_TallonSouth
			side = start_side.B
		"Transport to Tallon Overworld South (Mines)":
			path = $TallonSouth_MinesEast
			side = start_side.B
		"Transport to Tallon Overworld West":
			path = $TallonWest_MagmoorEast
			side = start_side.B
		"Transport to Magmoor Caverns South (Phendrana)":
			path = $MagmoorSouth_PhendranaSouth
			side = start_side.B
		"Transport to Magmoor Caverns South (Mines)":
			path = $MagmoorSouth_MinesWest
			side = start_side.A
		"Transport to Magmoor Caverns West":
			path = $MagmoorWest_PhendranaNorth
			side = start_side.B
		"Transport to Tallon Overworld North":
			path = $ChozoWest_TallonNorth
			side = start_side.A
		"Transport to Tallon Overworld East":
			path = $ChozoEast_TallonEast
			side = start_side.A
		"Transport to Magmoor Caverns North":
			path = $ChozoNorth_MagmoorNorth
			side = start_side.A
		"Transport to Tallon Overworld South (Chozo)":
			path = $ChozoSouth_TallonSouth
			side = start_side.A
		"Transport to Phazon Mines East":
			path = $TallonSouth_MinesEast
			side = start_side.A
		"Transport to Magmoor Caverns East":
			path = $TallonWest_MagmoorEast
			side = start_side.A
		"Transport to Phazon Mines West":
			path = $MagmoorSouth_MinesWest
			side = start_side.B
		"Transport to Phendrana Drifts North":
			path = $MagmoorWest_PhendranaNorth
			side = start_side.A
		"Transport to Phendrana Drifts South":
			path = $MagmoorSouth_PhendranaSouth
			side = start_side.A
	return [path, side]


func makeIndicators():
	for path in elevator_info.keys():
		var side : start_side = elevator_info[path]
		var progress : float
		if side == start_side.A:
			progress = 0.0
		elif  side == start_side.B:
			progress = 1.0
		spawnIndicatorForPath(path, side, progress)
	timer.start()


func stopIndicators():
	timer.stop()
	for path in all_paths:
		path.visible = false


func _on_timer_timeout():
	makeIndicators()


func spawnIndicatorForPath(path3d : Path3D, side : start_side, progress : float) -> void:
	for i in range(1, counts[path3d.name]):
		if side == start_side.A:
			progress = (1.0/counts[path3d.name]) * i
		elif side == start_side.B:
			progress = 1 - (1.0/counts[path3d.name]) * i
		path3d.get_child(0).progress_ratio = progress
		var new_indicator = indicator.instantiate()
		path3d.get_parent().add_child(new_indicator)
		new_indicator.position = path3d.get_child(-1).global_position
		await create_tween().tween_interval(delay).finished


func setPathVisibility() -> void:
	for path in all_paths:
		if path not in elevator_info.keys():
			path.visible = false
		else:
			path.visible = true
