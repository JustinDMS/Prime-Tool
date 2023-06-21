extends Window
signal room_clicked(room_node : Node3D)

############################ TO DO #####################################
# 
########################################################################

@onready var map = $SubViewportContainer/SubViewport/Map
@onready var camera = $SubViewportContainer/SubViewport/Camera3D
@onready var hud = $SubViewportContainer/SubViewport/Camera3D/CameraHUD

@onready var label_room = $SubViewportContainer/SubViewport/Camera3D/CameraHUD/MarginContainer/HBoxContainer/VBoxContainer2/Label_RoomName

var zoom_speed : float = 50.0
var zoom_lerp : float = 0.8
var drag_sensitivity : float = 1.0
var camera_x_sensitivity : float = 0.005
var camera_y_sensitivity : float = 0.005
var camera_home : Transform3D
var move_speed : float = 25.0
var move_lerp : float = 0.25


func _ready():
	camera_home = camera.transform


func _process(_delta):
	if Input.is_action_pressed("move_up"):
		camera.position.y = lerp(camera.position.y, camera.position.y + move_speed, move_lerp)
	if Input.is_action_pressed("move_down"):
		camera.position.y = lerp(camera.position.y, camera.position.y - move_speed, move_lerp)


func _input(event):
	if Input.is_action_just_pressed("reset_map"):
		camera.transform = camera_home
	
	if Input.is_action_just_pressed("scroll_in"):
		camera.position = lerp(camera.position, camera.position - (camera.get_global_transform().basis.z * zoom_speed), zoom_lerp)
	if Input.is_action_just_pressed("scroll_out"):
		camera.position = lerp(camera.position, camera.position + (camera.get_global_transform().basis.z * zoom_speed), zoom_lerp)
	
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("pan_map"):
			camera.position -= Vector3(event.relative.x / drag_sensitivity, 0, event.relative.y / drag_sensitivity).rotated(Vector3.UP, camera.rotation.y)
		elif Input.is_action_pressed("right_click"):
			camera.rotate_y(-event.relative.x * camera_x_sensitivity)
			camera.rotation.x -= event.relative.y * camera_y_sensitivity
			camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	
	if Input.is_action_just_pressed("left_click"):
		var clicked_room = getRoomMeshFromClick()
		if clicked_room:
			emit_signal("room_clicked", clicked_room.get_parent())
			label_room.set_text(clicked_room.get_parent().name)


func _on_close_requested():
	queue_free()


func getRoomMeshFromClick() -> MeshInstance3D:
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 5000
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = camera.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	if raycast_result:
		return raycast_result.collider.get_parent()
	return null
