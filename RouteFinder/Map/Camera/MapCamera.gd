extends Camera3D

var zoom_speed : float = 50.0
var zoom_lerp : float = 0.8
var drag_sensitivity : float = 1.0
var camera_x_sensitivity : float = 0.005
var camera_y_sensitivity : float = 0.005
var camera_home : Transform3D
var move_speed : float = 25.0
var move_lerp : float = 0.25


func _ready():
	camera_home = transform


func _process(_delta):
	if Input.is_action_pressed("move_up"):
		position.y = lerp(position.y, position.y + move_speed, move_lerp)
	if Input.is_action_pressed("move_down"):
		position.y = lerp(position.y, position.y - move_speed, move_lerp)


func _input(event):
	if Input.is_action_just_pressed("reset_map"):
		transform = camera_home
	
	if Input.is_action_just_pressed("scroll_in"):
		position = lerp(position, position - (get_global_transform().basis.z * zoom_speed), zoom_lerp)
	if Input.is_action_just_pressed("scroll_out"):
		position = lerp(position, position + (get_global_transform().basis.z * zoom_speed), zoom_lerp)
	
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("pan_map"):
			position -= Vector3(event.relative.x / drag_sensitivity, 0, event.relative.y / drag_sensitivity).rotated(Vector3.UP, rotation.y)
		elif Input.is_action_pressed("right_click"):
			rotate_y(-event.relative.x * camera_x_sensitivity)
			rotation.x -= event.relative.y * camera_y_sensitivity
			rotation.x = clamp(rotation.x, -PI/2, PI/2)
