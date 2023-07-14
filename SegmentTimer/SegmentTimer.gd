extends Control

@onready var t1_hh = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time1/T1_HH
@onready var t1_mm = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time1/T1_MM
@onready var t1_ss = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time1/T1_SS
@onready var t1_mil = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time1/T1_MIL

@onready var t2_hh = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time2/T2_HH
@onready var t2_mm = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time2/T2_MM
@onready var t2_ss = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time2/T2_SS
@onready var t2_mil = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time2/T2_MIL

@onready var result = $MarginContainer/VBoxContainer/HBoxContainer3/LineEdit_Result
@onready var result_formatted = $MarginContainer/VBoxContainer/HBoxContainer3/LineEdit_ResultFormatted

const snap : float = 0.001
var current_operation := 0


func _ready():
	pass


func validateInput(text, node):
	for i in text:
		if not i.is_valid_int():
			node.delete_char_at_caret()
	
	if node == t1_mm or node == t1_ss or node == t2_mm or node == t2_ss:
		if int(text) >= 60:
			node.delete_char_at_caret()
	
	if node != t1_mil and node != t2_mil:
		if len(text) == 2:
			focusNextNode(node.find_next_valid_focus())
	
	else:
		if len(text) == 3:
			focusNextNode(node.find_next_valid_focus())


func makeSeconds(hour_node, minute_node, second_node, millisecond_node):
	var hour = int(hour_node.get_text())
	var minute = int(minute_node.get_text())
	var second = float(second_node.get_text()) + float("." + millisecond_node.get_text())
	
	if hour > 0:
		hour = hour * 60 # Minutes
		hour = hour * 60 # Seconds
	
	if minute > 0:
		minute = minute * 60
	
	return snappedf(hour + minute + second, snap)


func formatSeconds(seconds_format):
	
	var hour = 0
	var minute = 0
	var second = 0
	var temp
	
	if seconds_format >= 3600:
		
		var temp_2
		
		minute = seconds_format / 60 # Get total minutes
		hour = floor(minute / 60) # Get hours
		
		temp = hour * 60 # Get minutes to subtract from total
		minute = floor(minute - temp)
		
		temp = minute * 60 # Get seconds to subtract from total
		temp_2 = hour * 60 * 60
		second = snappedf(seconds_format - temp - temp_2, snap)
		
		if minute < 10:
			minute = "0" + str(minute)
		
		if second < 10:
			second = "0" + str(second)
		
		return str(hour) + ":" + str(minute) + ":" + str(second)
	
	elif seconds_format >= 60:
		minute = floor(seconds_format / 60) # Get total minutes
		temp = minute * 60
		second = snappedf(seconds_format - temp, snap)
		
		if second < 10:
			second = "0" + str(second)
		
		return str(minute) + ":" + str(second)
	
	else: 
		return str(snappedf(seconds_format, snap))


func clearTime1():
	t1_hh.clear()
	t1_mm.clear()
	t1_ss.clear()
	t1_mil.clear()


func clearTime2():
	t2_hh.clear()
	t2_mm.clear()
	t2_ss.clear()
	t2_mil.clear()


func clearResults():
	result.clear()
	result_formatted.clear()


func focusNextNode(node):
	node.grab_focus()


func _on_T1_HH_text_changed(new_text):
	validateInput(new_text, t1_hh)


func _on_T1_MM_text_changed(new_text):
	validateInput(new_text, t1_mm)


func _on_T1_SS_text_changed(new_text):
	validateInput(new_text, t1_ss)


func _on_T1_MIL_text_changed(new_text):
	validateInput(new_text, t1_mil)


func _on_T2_HH_text_changed(new_text):
	validateInput(new_text, t2_hh)


func _on_T2_MM_text_changed(new_text):
	validateInput(new_text, t2_mm)


func _on_T2_SS_text_changed(new_text):
	validateInput(new_text, t2_ss)


func _on_T2_MIL_text_changed(new_text):
	validateInput(new_text, t2_mil)


func _on_Option_Operation_item_selected(index):
	current_operation = index


func _on_Button_Calculate_pressed():
	var time_1 = makeSeconds(t1_hh, t1_mm, t1_ss, t1_mil)
	var time_2 = makeSeconds(t2_hh, t2_mm, t2_ss, t2_mil)
	
	match current_operation:
		0: # Add
			result.set_text(str(time_1 + time_2))
			result_formatted.set_text(formatSeconds(time_1 + time_2))
		1: # Subtract
			result.set_text(str(snapped(time_1 - time_2, snap)))
			result_formatted.set_text(formatSeconds(time_1 - time_2))


func _on_Button_Clear_pressed():
	clearTime1()
	clearTime2()


func _on_Button_Clear1_pressed():
	clearTime1()


func _on_Button_Clear2_pressed():
	clearTime2()


func _on_T1_HH_text_entered(_new_text):
	focusNextNode(t1_hh.find_next_valid_focus())


func _on_T1_MM_text_entered(_new_text):
	focusNextNode(t1_mm.find_next_valid_focus())


func _on_T1_SS_text_entered(_new_text):
	focusNextNode(t1_ss.find_next_valid_focus())


func _on_T1_MIL_text_entered(_new_text):
	focusNextNode(t1_mil.find_next_valid_focus())


func _on_T2_HH_text_entered(_new_text):
	focusNextNode(t2_hh.find_next_valid_focus())


func _on_T2_MM_text_entered(_new_text):
	focusNextNode(t2_mm.find_next_valid_focus())


func _on_T2_SS_text_entered(_new_text):
	focusNextNode(t2_ss.find_next_valid_focus())


func _on_T2_MIL_text_entered(_new_text):
	focusNextNode(t2_mil.find_next_valid_focus())


func _on_Button_CopySeconds_pressed():
	DisplayServer.clipboard_set(result.get_text())


func _on_Button_CopyFormatted_pressed():
	DisplayServer.clipboard_set(result_formatted.get_text())


func _on_button_swap_times_pressed():
	var temp_t1_hh = t1_hh.get_text()
	var temp_t1_mm = t1_mm.get_text()
	var temp_t1_ss = t1_ss.get_text()
	var temp_t1_mil = t1_mil.get_text()
	
	t1_hh.set_text(t2_hh.get_text())
	t1_mm.set_text(t2_mm.get_text())
	t1_ss.set_text(t2_ss.get_text())
	t1_mil.set_text(t2_mil.get_text())
	
	t2_hh.set_text(temp_t1_hh)
	t2_mm.set_text(temp_t1_mm)
	t2_ss.set_text(temp_t1_ss)
	t2_mil.set_text(temp_t1_mil)
