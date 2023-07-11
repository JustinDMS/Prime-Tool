extends Control

############################ TO DO #####################################
# Start Time being zero has unexpected behavior
# Fix script and python pathing
########################################################################

@export var time_interval : float = 1.0 # Default 1.0

@onready var time_box = $MarginContainer/HBoxContainer/TimeBox
@onready var timer = $Timer
@onready var hooked_box = $MarginContainer/HBoxContainer/Display/HBoxContainer/CheckBox_Hooked
@onready var scanning_box = $MarginContainer/HBoxContainer/Display/HBoxContainer/CheckBox_Scanning
@onready var max_times_line_edit = $MarginContainer/HBoxContainer/Display/MarginContainer/HBoxContainer3/VBoxContainer/HBoxContainer2/LineEdit
@onready var best_time_label = $MarginContainer/HBoxContainer/Display/MarginContainer/HBoxContainer3/VBoxContainer/HBoxContainer/VBoxContainer2/BestTime
@onready var worst_time_label = $MarginContainer/HBoxContainer/Display/MarginContainer/HBoxContainer3/VBoxContainer/HBoxContainer/VBoxContainer2/WorstTime
@onready var avg_time_label = $MarginContainer/HBoxContainer/Display/MarginContainer/HBoxContainer3/VBoxContainer/HBoxContainer/VBoxContainer2/AverageTime
@onready var delta_label = $MarginContainer/HBoxContainer/Display/MarginContainer/HBoxContainer3/VBoxContainer2/Label_Delta
@onready var goal_time_line_edit = $MarginContainer/HBoxContainer/Display/MarginContainer/HBoxContainer3/VBoxContainer2/HBoxContainer2/LineEdit
@onready var start_time_line_edit = $MarginContainer/HBoxContainer/Display/MarginContainer/HBoxContainer3/VBoxContainer2/HBoxContainer/LineEdit

const red := Color.RED
const green := Color.GREEN
const blue := Color.BLUE

var script_path : String
var last_time : float
var hooked := false
var max_times : int = 20
var avg_time : float
var ignore_time : float
var ignore_next_time := false
var selected_time : int


func _ready():
	timer.set_wait_time(time_interval)
	script_path = getScriptPath()


func _input(_event):
	if Input.is_action_just_pressed("del_time") and is_visible_in_tree():
		if selected_time != null:
			time_box.remove_item(selected_time)
			updateTimes()


func getHooked() -> String:
	var output = []
	OS.execute("python.exe", [script_path + "pyIsHooked.py"], output)
	return output[0]


func getRawLastTime() -> String:
	var output = []
	OS.execute("python.exe", [script_path + "pyDME.py"], output)
	return output[0]


func formatBool(input : String) -> bool:
	var formatted := input[0]
	match formatted:
		"T": 
			return true
		"F":
			return false
		_:
			print("Couldn't read string")
			return false


func formatTime(input : String) -> float:
	var formatted = float(input.get_slice("\\", 0))
	formatted = snappedf(formatted, 0.001)
	return formatted


func _on_timer_timeout():
	
	var new_time = formatTime(getRawLastTime())
	if new_time == last_time or new_time == ignore_time: return
	elif new_time == float(start_time_line_edit.get_text()):
		ignore_next_time = true
		print("Ignoring next time")
		return
	elif ignore_next_time:
		ignore_time = new_time
		ignore_next_time = false
		return
	else:
		last_time = new_time
	
		updateDelta(new_time)
		addNewTime()


func addNewTime() -> void:
	if not time_box.item_count + 1 <= max_times:
		time_box.remove_item(time_box.item_count - 1)
	
	time_box.add_item(str(last_time))
	time_box.move_item(time_box.item_count - 1, 0)
	updateTimes()


func _on_button_hook_pressed():
	hooked = formatBool(getHooked())
	hooked_box.button_pressed = hooked


func _on_check_box_scanning_toggled(button_pressed):
	if button_pressed:
		timer.start()
	else:
		timer.stop()


func _on_check_box_hooked_toggled(button_pressed):
	if button_pressed:
		scanning_box.disabled = false
	else:
		scanning_box.disabled = true


func _on_line_edit_text_changed(new_text):
	if not new_text.is_valid_int():
		max_times_line_edit.delete_char_at_caret()
	else:
		max_times = int(new_text)
		time_box.max_text_lines = max_times


func updateTimes() -> void:
	var total : float = 0.0
	for i in range(0, time_box.item_count):
		total += float(time_box.get_item_text(i))
	avg_time_label.set_text(str(snappedf(total / time_box.item_count, 0.016)))
	resetBestTime()
	resetWorstTime()


func updateDelta(time : float) -> void:
	var goal_time = float(goal_time_line_edit.get_text())
	var delta = goal_time - time
	if time > goal_time:
		delta_label.add_theme_color_override("font_color", red)
		delta_label.set_text("+ " + str(delta * -1))
	if time == goal_time:
		delta_label.add_theme_color_override("font_color", blue)
		delta_label.set_text("= " + str(delta))
	if time < goal_time:
		delta_label.add_theme_color_override("font_color", green)
		delta_label.set_text("- " + str(delta))


func _on_time_box_item_selected(index):
	selected_time = index


func resetBestTime():
	var temp : float = 1000
	for t in range(0, time_box.item_count):
		if float(time_box.get_item_text(t)) < temp:
			temp = float(time_box.get_item_text(t))
	best_time_label.set_text(str(temp))


func resetWorstTime():
	var temp : float = 0
	for t in range(0, time_box.item_count):
		if float(time_box.get_item_text(t)) > temp:
			temp = float(time_box.get_item_text(t))
	worst_time_label.set_text(str(temp))


func _on_button_reset_best_pressed():
	resetBestTime()


func _on_button_reset_worst_pressed():
	resetWorstTime()


func getScriptPath() -> String: return OS.get_executable_path().rsplit("/", true, 1)[0] + "/Scripts/"
