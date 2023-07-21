extends Control

@onready var hooked_checkbox = $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/CheckBox_Hooked
@onready var status_label = $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Label_Status
@onready var label_timer = $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Label_Timer
@onready var start_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Button_Start
@onready var stop_button = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Button_Stop
@onready var time_list = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TimeList
@onready var average_speed_label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label_AverageSpeed
@onready var max_times_line_edit = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/LineEdit
@onready var average_time_label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label_AverageTime
@onready var graph = $MarginContainer/VBoxContainer/HBoxContainer/Graph

# Directories and paths
var dir
var interpreter_path
var hook_script_path
var retrieve_script_path

# Scripting
var is_hooked := false
var can_retrieve := false
var retrieve_thread : Thread

# Data Display
var previous_unique_time : float
var speed_values : Array


func _ready():
	updateDirectories()
	graph.add_plot_item("Speed", Color.GREEN, 1.0)


func _process(_delta):
	if can_retrieve and is_hooked:
		retrieveData()


func updateDirectories() -> void:
	dir = OS.get_executable_path().get_base_dir()
	interpreter_path = dir + "/Scripting/venv/Scripts/python.exe"
	hook_script_path = dir + "/Scripting/Scripts/autotimer_hook.py"
	retrieve_script_path = dir + "/Scripting/Scripts/autotimer_retrieve.py"
	
	if !OS.has_feature("template"): # If running in-editor
		print("Not exported!")
		interpreter_path = ProjectSettings.globalize_path("res://Scripting/venv/Scripts/python.exe")
		hook_script_path =  ProjectSettings.globalize_path("res://Scripting/Scripts/autotimer_hook.py")
		retrieve_script_path = ProjectSettings.globalize_path("res://Scripting/Scripts/autotimer_retrieve.py")


func newThread() -> Thread:
	var thread = Thread.new()
	#print("New Thread ID: ", thread.get_id())
	return thread


func checkHooked() -> bool:
	var output : Array = []
	var callable := Callable(self, "executeScript").bind(hook_script_path, output)
	
	var thread : Thread = newThread()
	
	# Start Thread
	var error = thread.start(callable)
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
	else:
		print(script_result)
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
	status_label.set_text("Hook failed :(")
	label_timer.start()


func statusTween() -> void:
	var invis := Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.finished.connect(Callable(self, "setLabelModulate").bind(invis))
	tween.tween_property(status_label, "modulate", invis, 0.5)


func setLabelModulate(color : Color) -> void:
	status_label.modulate = color


func _on_label_timer_timeout() -> void:
	statusTween()


func retrieveData() -> void:
	var output : Array = []
	var callable := Callable(self, "executeScript").bind(retrieve_script_path, output)
	
	retrieve_thread = newThread()
	var error = retrieve_thread.start(callable)
	if error != OK:
		print("Couldn't create thread")
		can_retrieve = false 
		return
	
	var data = retrieve_thread.wait_to_finish()
	if data[0].match("Not Hooked"):
		can_retrieve = false
		_on_button_hook_pressed()
	elif data:
		updateDisplay(formatRetrieve(data))
	else:
		print("Error: empty data")


func executeScript(script_path : String, output : Array) -> Array:
	OS.execute(interpreter_path, [script_path], output, true, false)
	return output


func _on_button_start_pressed() -> void:
	can_retrieve = true


func _on_button_stop_pressed() -> void:
	can_retrieve = false


func formatRetrieve(data : Array) -> Array:
	var output : Array = data[0].split(",")
	var last_room_time = snappedf(float(output[0]) - 0.0005, 0.001) # Subtracting 0.0005 adjusts the rounding to match the Practice Mod
	var speed = float(output[1])
	return [last_room_time, speed]


func updateDisplay(data : Array) -> void:
	var last_room_time = data[0]
	var speed = data[1]
	if addTimeToList(last_room_time):
		print("Total speed values: ", len(speed_values))
		print("Room time: ", last_room_time)
		print("")
		average_speed_label.set_text(str(calculateAverageSpeed(speed_values)))
		updateGraph(last_room_time)
		speed_values.clear()
	addSpeedValue(speed)


func addTimeToList(time : float) -> bool:
	if time != previous_unique_time:
		# If adding the new time would make the number of times > max times
		if time_list.item_count == int(max_times_line_edit.get_text()):
			time_list.remove_item(time_list.item_count - 1)
		
		time_list.add_item(str(time))
		time_list.move_item(time_list.item_count - 1, 0)
		previous_unique_time = time
		setAverageTime()
		return true
	return false


func addSpeedValue(speed : float) -> void:
	speed_values.append(speed)


func calculateAverageSpeed(speeds : Array) -> float:
	var average_speed : float = 0.0
	for speed in speeds:
		average_speed += speed
	return snappedf(average_speed/len(speeds), 0.01)


func _on_line_edit_text_changed(new_text):
	if not new_text.is_valid_int():
		max_times_line_edit.delete_char_at_caret()


func setAverageTime() -> void:
	var average_time : float = 0.0
	for i in range(0, time_list.item_count):
		average_time += float(time_list.get_item_text(i))
	average_time = average_time/time_list.item_count
	average_time_label.set_text(str(snappedf(average_time - 0.0005, 0.001)))


func updateGraph(time : float) -> void:
	graph.clear()
	graph.setMax(ceilf(time))
	var step : float = time/len(speed_values)
	for i in range(0, len(speed_values)):
		graph.add_point(Vector2((i+1)*step, speed_values[i])) # Vector2(Time(seconds),Speed)
