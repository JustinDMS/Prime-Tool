extends Control

@onready var hooked_checkbox = $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/CheckBox_Hooked
@onready var status_label = $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Label_Status
@onready var label_timer = $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Label_Timer
@onready var start_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Button_Start
@onready var stop_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Button_Stop
@onready var time_list = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TimeList

var dir
var interpreter_path
var hook_script_path
var retrieve_script_path

var is_hooked := false
var can_retrieve := false
var retrieve_thread : Thread


func _ready():
	updateDirectories()


func _process(_delta):
	if can_retrieve and is_hooked:
		retrieveData()


func updateDirectories() -> void:
	dir = OS.get_executable_path().get_base_dir()
	interpreter_path = dir + "/Scripting/env/Scripts/python.exe"
	hook_script_path = dir + "/Scripting/Scripts/autotimer_hook.py"
	retrieve_script_path = dir + "/Scripting/Scripts/autotimer_retrieve.py"
	
	if !OS.has_feature("template"): # If running in-editor
		print("Not exported!")
		interpreter_path = ProjectSettings.globalize_path("res://Scripting/env/Scripts/python.exe")
		hook_script_path =  ProjectSettings.globalize_path("res://Scripting/Scripts/autotimer_hook.py")
		retrieve_script_path = ProjectSettings.globalize_path("res://Scripting/Scripts/autotimer_retrieve.py")


func newThread() -> Thread:
	var thread = Thread.new()
	print("New Thread ID: ", thread.get_id())
	return thread


func checkHooked() -> bool:
	var output : Array = []
	var callable := Callable(self, "executeScript").bind(hook_script_path, output)
	
	var thread : Thread = newThread()
	
	# Start Thread
	var error = thread.start(callable)
	print(error)
	if error != OK:
		print("Couldn't create thread")
		return false
	
	# Tell thread to stop and return value
	var wait_for_thread = thread.wait_to_finish()
	return formatHooked(wait_for_thread)


func formatHooked(script_result : Array) -> bool:
	if script_result[0] is String and script_result[0].is_valid_int():
		match int(script_result[0]):
			0:
				print("Couldn't hook")
				return false
			1:
				print("Hook successful")
				return true
	return false


func _on_button_hook_pressed():
	var hooked = checkHooked()
	is_hooked = hooked
	hooked_checkbox.button_pressed = hooked
	showStatus(hooked)


func showStatus(hooked : bool) -> void:
	setLabelModulate(Color(1, 1, 1, 1))
	if hooked:
		status_label.set_text("Hook successful!")
		label_timer.start()
		return
	status_label.set_text("Hook failed")
	label_timer.start()


func statusTween() -> void:
	var invis := Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.finished.connect(Callable(self, "setLabelModulate").bind(invis))
	tween.tween_property(status_label, "modulate", invis, 0.5)


func setLabelModulate(color : Color) -> void:
	status_label.modulate = color


func _on_label_timer_timeout():
	statusTween()


func retrieveData() -> void:
	var output : Array = []
	var callable := Callable(self, "executeScript").bind(retrieve_script_path, output)
	
	if not retrieve_thread:
		retrieve_thread = newThread()
		var error = retrieve_thread.start(callable)
		if error != OK:
			print("Couldn't create thread")
			can_retrieve = false 
			return
	else:
		var data = callable.call()
		if data[0].match("Not Hooked"):
			can_retrieve = false
			_on_button_hook_pressed()
		elif data:
			updateDisplay(formatRetrieve(data))
		else:
			print("Error no data")


func executeScript(script_path : String, output : Array) -> Array:
	OS.execute(interpreter_path, [script_path], output, true, false)
	return output


func _on_button_start_pressed():
	can_retrieve = true


func _on_button_stop_pressed():
	can_retrieve = false


func formatRetrieve(data : Array) -> Array:
	var output : Array = data[0].split(",")
	var last_room_time = snappedf(float(output[0]) - 0.0005, 0.001) # Subtracting 0.0005 adjusts the rounding to match prime's IGT
	var speed = float(output[1])
	return [last_room_time, speed]


func updateDisplay(data : Array) -> void:
	print(data)
	var last_room_time = data[0]
	var speed = data[1]
	addTimeToList(last_room_time)


func addTimeToList(time : float) -> void:
	time_list.add_item(str(time))
	time_list.move_item(time_list.item_count - 1, 0)
