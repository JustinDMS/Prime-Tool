extends Control

############################ TO DO #####################################
# 
########################################################################

@onready var averages_node = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var times_container = $MarginContainer/VBoxContainer/VBox_Times
@onready var averages_result = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit_Average
@onready var times = {
	1 : $MarginContainer/VBoxContainer/VBox_Times/LineEdit
}

var num_times = 1
var window_size := Vector2(550, 200) 


func _ready():
	pass


func validateInput(text, node):
	for i in text:
		if not i.is_valid_int():
			node.delete_char_at_caret()


func validateInputFloat(text, node):
	for i in text:
		if not i.is_valid_float():
			node.delete_char_at_caret()


func updateNumTimes():
	num_times = clamp(num_times, 1, 99)
	averages_node.set_text(str(num_times))


func updateWindowSize():
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_MAXIMIZED:
		var temp : Vector2 = window_size
		temp.y = window_size.y + 34 * num_times
		get_window().set_size(temp)


func addLineEdit():
	var line_edit = LineEdit.new()
	times_container.add_child(line_edit)
	var key = times.size() + 1
	line_edit.set_placeholder("Time " + str(key))
	times[key] = line_edit


func removeLineEdit():
	if times.size() > 1:
		times[times.size()].queue_free()
		times.erase(times.size())


func updateAverage():
	var all_times = times.keys()
	var total = 0
	
	for i in all_times:
		var time = float(times[i].get_text())
		total += time
	
	total = snapped(total / times.size(), 0.001)
	
	averages_result.set_text(str(total))



func _on_Button_Increment_pressed():
	num_times += 1
	updateNumTimes()
	updateWindowSize()
	addLineEdit()


func _on_Button_Decrement_pressed():
	num_times -= 1
	updateNumTimes()
	updateWindowSize()
	removeLineEdit()


func _on_LineEdit_text_entered(new_text):
	var is_add = num_times < int(new_text)
	num_times = int(new_text)
	updateNumTimes()
	updateWindowSize()

	if is_add:
		while times.size() < num_times:
			addLineEdit()
	else:
		while times.size() > num_times:
			removeLineEdit()


func _on_LineEdit_text_changed(new_text):
	validateInput(new_text, averages_node)


func _on_Button_Calculate_pressed():
	updateAverage()


func _on_Button_Clear_pressed():
	for i in times_container.get_children():
		i.clear()
	averages_result.clear()


func _on_Button_Copy_pressed():
	DisplayServer.clipboard_set(averages_result.get_text())
