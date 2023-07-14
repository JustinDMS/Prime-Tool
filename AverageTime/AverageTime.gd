extends Control

@onready var averages_node = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var times_container = $MarginContainer/VBoxContainer/ScrollContainer/VBox_Times
@onready var averages_result = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit_Average
@onready var times = {
	1 : $MarginContainer/VBoxContainer/ScrollContainer/VBox_Times/LineEdit
}

var num_times : int = 1


func _ready():
	pass


func validateInput(text : String, node : LineEdit) -> void:
	for i in text:
		if not i.is_valid_int():
			node.delete_char_at_caret()


func validateInputFloat(text : String, node : LineEdit) -> void:
	for i in text:
		if not i.is_valid_float():
			node.delete_char_at_caret()


func updateNumTimes() -> void:
	num_times = clamp(num_times, 1, 99)
	averages_node.set_text(str(num_times))


func addLineEdit() -> void:
	var line_edit = LineEdit.new()
	times_container.add_child(line_edit)
	var key = times.size() + 1
	line_edit.set_placeholder("Time " + str(key))
	times[key] = line_edit


func removeLineEdit() -> void:
	if times.size() > 1:
		times[times.size()].queue_free()
		times.erase(times.size())


func updateAverage() -> void:
	var all_times = times.keys()
	var total = 0
	
	for i in all_times:
		var time = float(times[i].get_text())
		total += time
	
	total = snapped(total / times.size(), 0.001)
	
	averages_result.set_text(str(total))



func _on_Button_Increment_pressed() -> void:
	num_times += 1
	updateNumTimes()
	addLineEdit()


func _on_Button_Decrement_pressed() -> void:
	num_times -= 1
	updateNumTimes()
	removeLineEdit()


func _on_LineEdit_text_entered(new_text : String) -> void:
	var is_add = num_times < int(new_text)
	num_times = int(new_text)
	updateNumTimes()

	if is_add:
		while times.size() < num_times:
			addLineEdit()
	else:
		while times.size() > num_times:
			removeLineEdit()


func _on_LineEdit_text_changed(new_text : String) -> void:
	validateInput(new_text, averages_node)


func _on_Button_Calculate_pressed() -> void:
	updateAverage()


func _on_Button_Clear_pressed() -> void:
	for i in times_container.get_children():
		i.clear()
	averages_result.clear()


func _on_Button_Copy_pressed() -> void:
	DisplayServer.clipboard_set(averages_result.get_text())
