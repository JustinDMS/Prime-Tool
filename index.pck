GDPC                  �	                                                                         X   res://.godot/exported/133200997/export-3bb9356b802a82c6f2dfde91dd7520b6-SegmentTimer.scn�P      �      ح1Ȗ�[g򘞵�E    X   res://.godot/exported/133200997/export-7cf3fd67ad9f55210191d77b582b8209-default_env.res �h      �	      _@�@(L�!e� #�q.    X   res://.godot/exported/133200997/export-9ff6a75617b56735244e0df0ba1f71ca-AverageTime.scn �	      �
      k�����}�Y0Q뼼�[    X   res://.godot/exported/133200997/export-b0b59308ebad1c5daf28308ceba0275e-RouteFinder.scn �*      �       '�#�`_M�����    P   res://.godot/exported/133200997/export-bcb0d2eb5949c52b6a65bfe9de3e985b-Main.scn@�     �      E
a��0iB���L��    ,   res://.godot/global_script_class_cache.cfg          1      :o��՞Z��344���    D   res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex�r      L      ���t�C#y��� �    X   res://.godot/imported/index.apple-touch-icon.png-8085a11cc297d91deb55511843765958.ctex  ��      `{      �Ôߢ�M�f+_o�
�    L   res://.godot/imported/index.icon.png-5665fad188e88d1e882500a4376bfe02.ctex  @     L      ���t�C#y��� �    H   res://.godot/imported/index.png-5122033cac747157decad52589e2295c.ctex   0�     -      �%�$����<�׿�+       res://.godot/uid_cache.bin  06     N      M��#��<j �i.�        res://AverageTime/AverageTime.gd@      s      ����K��Vѳ��)�.    (   res://AverageTime/AverageTime.tscn.remap`�     h       ]쵸����U�E'h�       res://Main.gd   @�     �       ��y'cHi��E�� �T       res://Main.tscn.remap    �     a       3 J�M�B�b��}�       res://RoomData.json ��     E�      �W'=zwl�wȖ�iw        res://RouteFinder/RouteFinder.gdP      e      �e��.��`�l��5    (   res://RouteFinder/RouteFinder.tscn.remap��     h       �k��;����)XX]g�    $   res://SegmentTimer/SegmentTimer.gd  P:      �      >ҹ��l[L���I�N�;    ,   res://SegmentTimer/SegmentTimer.tscn.remap  @�     i       ٕF���Z��d�<��       res://default_env.tres.remap��     h       cXv�S��P�O�Tq�o       res://icon.ico   �     >     .ɔ��*����       res://icon.png  ��     �j      (�m��Ky���`�8T�       res://icon.png.import   ��      �      ��S�9ĵ� �Q����    (   res://index.apple-touch-icon.png.import �<           �q�����eX�*��\       res://index.icon.png.import 0�     �      r�ǉ�����'�E�%�       res://index.png.import  P�     �      S��dO��@�g|F���       res://project.binary�7     �      s`�2	l
�ț䨬KP`    �`��list=Array[Dictionary]([{
"base": &"EditorVCSInterface",
"class": &"GitAPI",
"icon": "",
"language": &"NativeScript",
"path": "res://addons/godot-git-plugin/git_api.gdns"
}, {
"base": &"Control",
"class": &"RouteFinder",
"icon": "",
"language": &"GDScript",
"path": "res://RouteFinder/RouteFinder.gd"
}])
����q���d����extends Control

@onready var averages_node = $VBoxContainer/HBoxContainer/LineEdit
@onready var times_container = $VBoxContainer/VBox_Times
@onready var averages_result = $VBoxContainer/HBoxContainer/LineEdit_Average
@onready var times = {
	1 : $VBoxContainer/VBox_Times/LineEdit
}

var num_times = 1
var window_size = Vector2(400, 146)


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
	window_size.y = 146 + 34 * num_times
	get_window().set_size(window_size)


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
��yɢ�q�P�aRSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script !   res://AverageTime/AverageTime.gd ��������      local://PackedScene_cdwsq          PackedScene          	         names "   .      AverageTime    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    VBoxContainer    anchor_left    offset_left    offset_top    offset_right    offset_bottom    HBoxContainer    Button_Increment    text    Button    Button_Decrement 	   LineEdit    placeholder_text    max_length    VBoxContainer2    custom_minimum_size    size_flags_horizontal    Button_Calculate    Button_Clear    LineEdit_Average 	   editable    Button_Copy    tooltip_text    flat    HSeparator    VBox_Times    size_flags_vertical    _on_Button_Increment_pressed    pressed    _on_Button_Decrement_pressed    _on_LineEdit_text_changed    text_changed    _on_LineEdit_text_entered    text_submitted    _on_Button_Calculate_pressed    _on_Button_Clear_pressed    _on_Button_Copy_pressed    	   variants                        �?                         ����   L7�=   � p?    ��     �A   ��̽     FC      +       -       1       5 
     �B             
   Calculate       Clear 
     �B                        Click to copy             Time 1       node_count             nodes     �   ��������       ����                                                          	   	   ����	               
               	      
                                      ����                    	   	   ����                          ����                                ����                                ����                                      	      ����                                      ����                                ����                                ����                         
             ����                                             !   !   ����                    	   "   ����                #                        ����                         conn_count             conns     1          %   $                     %   &                     (   '                     *   )                     %   +              	       %   ,                     %   -                    node_paths              editable_instances              version             RSRC;��C+j�class_name RouteFinder
extends Control

# UI Elements
@onready var option_room_1 = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer_A/Option_Room1
@onready var option_room_2 = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer_B/Option_Room2
@onready var option_world_1 = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer_A/Option_World1
@onready var option_world_2 = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer_B/Option_World2
@onready var result_label = $MarginContainer/HBoxContainer/VBoxContainer/Label_Result
@onready var copy_button = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Button_CopyText

# Pathfinding
enum point {POINT_A, POINT_B}
var room_path = []
var room_queue = []
var rooms_visited = {}
var distance = {}
var parent_rooms = {}
var room_data
var room_found := false
var worlds = {
	0 : "Tallon Overworld",
	1 : "Chozo Ruins",
	2 : "Magmoor Caverns",
	3 : "Phendrana Drifts",
	4 : "Phazon Mines",
}

# Player Inventory
var inventory = {
	"Power" : true,
	"Wave" : true,
	"Ice" : true,
	"Plasma" : true,
}

# Etc
var window_size : Vector2 = Vector2(600, 375)


func _ready():
	readJSON()
	buildRoomList(0, point.POINT_A)
	buildRoomList(0, point.POINT_B)


func readJSON():
	var file = FileAccess.open("res://RoomData.json", FileAccess.READ)
	var file_as_text = file.get_as_text()
	var test_json_conv = JSON.new()
	test_json_conv.parse(file_as_text)
	room_data = test_json_conv.get_data()


func adjustWindowSize():
	var temp_window = window_size
	temp_window.y += room_path.size() * 25
	get_window().set_size(temp_window)


func displayResults(end):
	adjustWindowSize()
	var text = ""
	var count = 0
	
	if not room_found:
		text = "Unable to find " + end
		result_label.set_text(text)
		return
	
	for i in room_path:
		text += room_path[count]
		count += 1
		if count < room_path.size():
			text += "\n"
	
	result_label.set_text(text)
	copy_button.set_text("Copy " + str(distance[end] + 1) + " rooms")


func findWorldIndex(room):
	
	if room in room_data["World"]["Tallon Overworld"]:
		return 0
	elif room in room_data["World"]["Chozo Ruins"]:
		return 1
	elif room in room_data["World"]["Magmoor Caverns"]:
		return 2
	elif room in room_data["World"]["Phendrana Drifts"]:
		return 3
	elif room in room_data["World"]["Phazon Mines"]:
		return 4 
	else:
		return null


func buildRoomList(world, end_point):
	
	var options_node
	
	if end_point == 0: # Point A
		options_node = option_room_1
	elif end_point == 1: # Point B
		options_node = option_room_2
	
	options_node.clear()
	
	var rooms_dict = room_data["World"][worlds[world]]
	
	for i in rooms_dict.keys():
		options_node.add_item(i)


func findPath(start : String, end : String):
	rooms_visited[start] = true
	room_queue.append(start)
	distance[start] = 0
	parent_rooms[start] = null
	room_found = false
	
	while room_queue.size() > 0:
		
		if findWorldIndex(room_queue[0]) == null:
			print("Invalid world for room: ", room_queue[0])
			room_queue.pop_front()
		else:
			var current_room = room_queue[0]
			var current_world = worlds[findWorldIndex(current_room)]
			var connecting = searchConnectingRooms(current_world, current_room, end)
			room_queue.pop_front()
			
			for i in connecting:
				if not i in rooms_visited:
					rooms_visited[i] = true
					room_queue.append(i)
	
	if room_found:
		constructRoomPath(start, end)
	else:
		displayResults(end)


func searchConnectingRooms(world, room, end):
	
	var temp_room_array = []

	for i in room_data["World"][world][room]:
		
		distance[i] = distance[room] + 1
		
		if not parent_rooms.has(i):
			parent_rooms[i] = room
		
		if not i == end and inventory[getDoorType(world, room, i)]:
			temp_room_array.append(i)
		else:
			if inventory[getDoorType(world, room, i)]:
				room_found = true
				room_queue.clear()
				return []
			else:
				print("Found destination but lack correct beam")
				print("Unable to enter " + i + " without ", getDoorType(world, room, i))
	
	return temp_room_array


func getDoorType(world, room_from, room_to) -> String:
	return room_data["World"][world][room_from][room_to]["Door"]


func constructRoomPath(start, end):
	
	room_path = [end]
	var previous_room = end
	
	while room_path.size() < distance[end]:
		var temp = parent_rooms[previous_room]
		if parent_rooms.has(temp):
			room_path.insert(0, temp)
			previous_room = temp
	
	room_path.insert(0, start)
	
	displayResults(end)


func resetContainers():
	room_path.clear()
	room_queue.clear()
	rooms_visited.clear()
	distance.clear()
	parent_rooms.clear()
	
	result_label.set_text("")
	copy_button.set_text("Copy")
	
	adjustWindowSize()


func _on_Option_World1_item_selected(index):
	buildRoomList(index, point.POINT_A)


func _on_Option_World2_item_selected(index):
	buildRoomList(index, point.POINT_B)


func _on_Button_GetRooms_pressed():
	var start = option_room_1.get_item_text(option_room_1.get_selected())
	var end = option_room_2.get_item_text(option_room_2.get_selected())
	var _world_start = option_world_1.get_selected_id()
	var _world_end = option_world_2.get_selected_id()
	
	# room_data["World"]["Chozo Ruins"] - Gets all rooms in Chozo Ruins
	# room_data["World"]["Tallon Overworld"]["Frigate Crash Site"] - Gets all connecting rooms in Frigate Crash Site
	
	if start == end:
		pass
	else:
		resetContainers()
		findPath(start, end)


func _on_Button_CopyText_pressed():
	DisplayServer.clipboard_set(result_label.get_text())


func _on_Button_Clear_pressed():
	resetContainers()


func _on_check_box_wave_toggled(button_pressed):
	inventory["Wave"] = button_pressed


func _on_check_box_ice_toggled(button_pressed):
	inventory["Ice"] = button_pressed


func _on_check_box_plasma_toggled(button_pressed):
	inventory["Plasma"] = button_pressed
9�G���O����RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script !   res://RouteFinder/RouteFinder.gd ��������      local://PackedScene_5fewy          PackedScene          	         names "   D      RouteFinder    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    MarginContainer    offset_bottom %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right    HBoxContainer 
   alignment    VBoxContainer    size_flags_horizontal    VBoxContainer_A    Label    text    Option_World1    item_count 	   selected    popup/item_0/text    popup/item_0/id    popup/item_1/text    popup/item_1/id    popup/item_2/text    popup/item_2/id    popup/item_3/text    popup/item_3/id    popup/item_4/text    popup/item_4/id    OptionButton    Option_Room1    fit_to_longest_item    VBoxContainer_B    Option_World2    Option_Room2    Button_GetRooms    Button    Button_CopyText    Button_Clear    Label_Result    size_flags_vertical    text_overrun_behavior    VSeparator    VBoxContainer2    horizontal_alignment    vertical_alignment    HSeparator    CheckBox_Wave    button_pressed 	   CheckBox    CheckBox_Ice    CheckBox_Plasma     _on_Option_World1_item_selected    item_selected     _on_Option_World2_item_selected    _on_Button_GetRooms_pressed    pressed    _on_Button_CopyText_pressed    _on_Button_Clear_pressed    _on_check_box_wave_toggled    toggled    _on_check_box_ice_toggled    _on_check_box_plasma_toggled    	   variants                        �?                           �B      Point A                    Tallon Overworld       Chozo Ruins       Magmoor Caverns       Phendrana Drifts       Phazon Mines                    Point B    
   Get Rooms       Copy       Clear    	   Settings          
   Wave Beam    	   Ice Beam       Plasma Beam       node_count             nodes     d  ��������       ����                                                          	   	   ����
                           
                                                     ����                                ����                                 ����                          ����                          "      ����                  	      
      	                                               !                 "   #   ����         $                    %   ����                          ����                          "   &   ����                  	      
      	                                               !                 "   '   ����                          ����                    )   (   ����                                ����                    )   *   ����                                 )   +   ����                                    ,   ����         -   	   .                  /   /   ����                       0   ����                          ����               1      2                 3   3   ����                          ����         -                  6   4   ����         5                       6   7   ����         5                       6   8   ����         5                      conn_count             conns     8          :   9              
       :   ;                     =   <                     =   >                     =   ?                     A   @                     A   B                     A   C                    node_paths              editable_instances              version             RSRCJL�extends Control

@onready var t1_hh = $VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time1/T1_HH
@onready var t1_mm = $VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time1/T1_MM
@onready var t1_ss = $VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time1/T1_SS
@onready var t1_mil = $VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time1/T1_MIL

@onready var t2_hh = $VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time2/T2_HH
@onready var t2_mm = $VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time2/T2_MM
@onready var t2_ss = $VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time2/T2_SS
@onready var t2_mil = $VBoxContainer/HBoxContainer/VBoxContainer/HBox_Time2/T2_MIL

@onready var result = $VBoxContainer/HBoxContainer3/LineEdit_Result
@onready var result_formatted = $VBoxContainer/HBoxContainer3/LineEdit_ResultFormatted

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
	var second = int(second_node.get_text())
	var millisecond = int(millisecond_node.get_text())
	
	if hour > 0:
		hour = hour * 60 # Minutes
		hour = hour * 60 # Seconds
	
	if minute > 0:
		minute = minute * 60
	
	if millisecond > 0:
		match len(str(millisecond)):
			1:
				millisecond = int(str(millisecond) + "00")
				millisecond = millisecond * 0.001
			2:
				millisecond = int(str(millisecond) + "0")
				millisecond = millisecond * 0.001
			3:
				if not str(millisecond).begins_with("0"):
					millisecond = millisecond * 0.001
				
	
	return hour + minute + second + millisecond


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
		second = seconds_format - temp - temp_2
		
		if minute < 10:
			minute = "0" + str(minute)
		
		if second < 10:
			second = "0" + str(second)
		
		return str(hour) + ":" + str(minute) + ":" + str(second)
	
	elif seconds_format >= 60:
		minute = floor(seconds_format / 60) # Get total minutes
		temp = minute * 60
		second = seconds_format - temp
		
		if second < 10:
			second = "0" + str(second)
		
		return str(minute) + ":" + str(second)
	
	else: return str(seconds_format)


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
			result.set_text(str(time_1 - time_2))
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
R���W�!�DQgZRSRC                     PackedScene            ��������                                                  ..    T1_MM    HBox_Time2    T2_HH    T1_HH    T1_SS    T2_MM    T1_MIL    T2_SS    T2_MIL    HBox_Time1    HBoxContainer2    Button_Calculate    .    resource_local_to_scene    resource_name 	   _bundled    script       Script #   res://SegmentTimer/SegmentTimer.gd ��������      local://PackedScene_7xq5c �         PackedScene          	         names "   _      SegmentTimer    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    VBoxContainer    anchor_left    offset_left    offset_top    offset_right    offset_bottom    HBoxContainer    HBox_Time1 
   alignment    T1_HH    focus_neighbor_right    focus_neighbor_bottom    focus_next    placeholder_text    max_length    caret_blink 	   LineEdit    Label    text    T1_MM    focus_neighbor_left    Label2    T1_SS    Label3    size_flags_vertical    T1_MIL    HBox_Time2    T2_HH    focus_neighbor_top    T2_MM    T2_SS    T2_MIL    Button_SwapTimes    Button    MarginContainer    custom_minimum_size    Option_Operation    item_count 	   selected    popup/item_0/text    popup/item_0/id    popup/item_1/text    popup/item_1/id    OptionButton    Button_Clear1    Button_Clear2    HBoxContainer2    Button_Calculate    Button_Clear    size_flags_horizontal    HBoxContainer3    LineEdit_Result 	   editable    Button_CopySeconds    tooltip_text    flat    LineEdit_ResultFormatted    Button_CopyFormatted    _on_T1_HH_text_changed    text_changed    _on_T1_HH_text_entered    text_submitted    _on_T1_MM_text_changed    _on_T1_MM_text_entered    _on_T1_SS_text_changed    _on_T1_SS_text_entered    _on_T1_MIL_text_changed    _on_T1_MIL_text_entered    _on_T2_HH_text_changed    _on_T2_HH_text_entered    _on_T2_MM_text_changed    _on_T2_MM_text_entered    _on_T2_SS_text_changed    _on_T2_SS_text_entered    _on_T2_MIL_text_changed    _on_T2_MIL_text_entered    _on_button_swap_times_pressed    pressed #   _on_Option_Operation_item_selected    item_selected    _on_Button_Clear1_pressed    _on_Button_Clear2_pressed    _on_Button_Calculate_pressed    _on_Button_Clear_pressed    _on_Button_CopySeconds_pressed !   _on_Button_CopyFormatted_pressed    	   variants    2                    �?                          L7�=   h�m?   	�u>     �A   �G��     �B                                             HH             :                                                     MM                                        SS       .                  	         sss               
                    
                                                                          
                                 
                         	         ⇅ 
     PB  PB      +       -       c 
     zC       
   Calculate       Clear       seconds              Click to copy       HH:MM:SS.sss       node_count    #         nodes       ��������       ����                                                          	   	   ����         
                     	      
                          ����                    	   	   ����                          ����                                ����                                                              ����                                ����                                                              ����                                ����                                                               ����         !                          "   ����                                                            #   ����                             $   ����	               %                                                           ����                             &   ����                %   !      "            "                                ����                             '   ����               %   #      $            %                                 ����         !                          (   ����            "   %                                                *   )   ����            &              +   +   ����   ,   '                          ����                    4   -   ����         .      /      0   (   1      2   )   3                 	   	   ����                    *   5   ����         !          *              *   6   ����         !          *                 7   ����                    *   8   ����   ,   +            ,              *   9   ����         :          -                 ;   ����                       <   ����         :          .   =   /              *   >   ����                     ?   0   @                    A   ����         :          1   =   /       !       *   B   ����                     ?   0   @                conn_count             conns     �          D   C                     F   E                     D   G                     F   H              	       D   I              	       F   J                     D   K                     F   L                     D   M                     F   N                     D   O                     F   P                     D   Q                     F   R                     D   S                     F   T                     V   U                     X   W                     V   Y                     V   Z                     V   [                     V   \                      V   ]              "       V   ^                    node_paths              editable_instances              version             RSRC��ȊRSRC                     Environment            ��������                                            d      resource_local_to_scene    resource_name    sky_material    process_mode    radiance_size    script    background_mode    background_color    background_energy_multiplier    background_intensity    background_canvas_max_layer    background_camera_feed_id    sky    sky_custom_fov    sky_rotation    ambient_light_source    ambient_light_color    ambient_light_sky_contribution    ambient_light_energy    reflected_light_source    tonemap_mode    tonemap_exposure    tonemap_white    ssr_enabled    ssr_max_steps    ssr_fade_in    ssr_fade_out    ssr_depth_tolerance    ssao_enabled    ssao_radius    ssao_intensity    ssao_power    ssao_detail    ssao_horizon    ssao_sharpness    ssao_light_affect    ssao_ao_channel_affect    ssil_enabled    ssil_radius    ssil_intensity    ssil_sharpness    ssil_normal_rejection    sdfgi_enabled    sdfgi_use_occlusion    sdfgi_read_sky_light    sdfgi_bounce_feedback    sdfgi_cascades    sdfgi_min_cell_size    sdfgi_cascade0_distance    sdfgi_max_distance    sdfgi_y_scale    sdfgi_energy    sdfgi_normal_bias    sdfgi_probe_bias    glow_enabled    glow_levels/1    glow_levels/2    glow_levels/3    glow_levels/4    glow_levels/5    glow_levels/6    glow_levels/7    glow_normalized    glow_intensity    glow_strength 	   glow_mix    glow_bloom    glow_blend_mode    glow_hdr_threshold    glow_hdr_scale    glow_hdr_luminance_cap    glow_map_strength 	   glow_map    fog_enabled    fog_light_color    fog_light_energy    fog_sun_scatter    fog_density    fog_aerial_perspective    fog_sky_affect    fog_height    fog_height_density    volumetric_fog_enabled    volumetric_fog_density    volumetric_fog_albedo    volumetric_fog_emission    volumetric_fog_emission_energy    volumetric_fog_gi_inject    volumetric_fog_anisotropy    volumetric_fog_length    volumetric_fog_detail_spread    volumetric_fog_ambient_inject    volumetric_fog_sky_affect -   volumetric_fog_temporal_reprojection_enabled ,   volumetric_fog_temporal_reprojection_amount    adjustment_enabled    adjustment_brightness    adjustment_contrast    adjustment_saturation    adjustment_color_correction        
   local://1 Q	         local://Environment_jtqdi e	         Sky             Environment                                RSRC�{��x�]_�8��PGST2   �   �      ����               � �        �K  RIFF�K  WEBPVP8L�K  /�ͨmۆ9e�#�_G-�� ��&��mc�n��ځ���� 
��$EVD�y��m��H��^��L�Z�=�1w������m۶m۶�������̬�=mTu��|�ǦR��.ٶU;�4�>���=�2 ������Y]���U�����%��޻p��$I�l[�$!�sߗ/���j���h�忻�  ij{m۶m[g�e۶m���vm��m#In'Nz̞�?�߶�x$m��W���m�gn۶m۶}߿ٶmcl��T\U�y�KΜ5��ڏ�m�#۶u=����PDB������YX��R���0��+��<�A����$IRm۶-��c,���o3�s�4:�m������:��m۶�ٶm#�m��l�6��mI����~�m�1I��i���
�3Ƕm۶m�6�Χ۶m��e�*U�H���ؗ��*_�m��d[[�cε�$�L�t���0'i���f339���9�`�9G�%I�j۶m���Z_��V�H�a@o�B��6ʪ�1�D ��z8.  �ݚʌ�ߪ \`��Ȥ '�$� �D"�L�fZ )sə5�9    ���U  ˧�����  ?�8A�^Wɿ��=�E ��j` �%�䌯p����`���B��~��}ty�?��'`P]����U�M� hW8 �yS�/����gk�����r�o0�T^��M���}�`�Z�֠�� &QsB(Ie����E�x6�i�.p�h;\6��vj��� OfJ>�w  ��r��=jk�C���H����0�   w��H -�0 �?�\������I,��jI	�$b0c�d�����?k?�� �76s�   \4�n ��w� ��Xa�?��Yy��4��Im͉�����D  �hp: ��?��A�N�������+�B�����`0�1� 0 źձ���G�ݻD;w�\����J��\1�d�E6,鏃�,=y���ok��h�LO��jkjkR�;>���/��  ֧� L���<���5���y�<��H@� ��<���1��&&)�ɢ�����q�~�V}_�ԧ�O�����**-	&'���&��mp�Noߩ�����������?�$��?�D�����Q�)S� ڀ>��\�q���yŞ��\i��X��8"��J���X�b	 �bF��*%����פ�>�^W" l� �%�z�֛���3k3�ג։"i�f\o���ZR�����em@�5� ���~�bOi�)�}z�q�HX`��8F�i���Č Ƣ�&00v,xl,L��`D�y*i0Fژ̾��Qb���a��Ϳ @�����?�y����P�[$e��/K��@	U/PB��������< `Ly,  ����ϫwK�?˗5���]F�@ 0  ���:�"� �����`b� ��5I1���dp:s_�P`$��I,��{t 9 H ���f�ƙ��u�Aԃk��S��?�� 5����"����  �( ����x�A_wy�������/ή����˸�z��f�a4�k� �ib�<kV �	`�����`���")L��A����H$����xH��e]��I���'�֎�n�?Q/ݓ��^�쥙3�� 5D�P�
Y���m���
����ͷ���r{ܰ|ܱy����Ot���ʩ3S�c2&k&�`ȓ�!� `d���رH:̘1�H�I��03.r1��oc�'�ħu��=8�uG�˃���C{l��n�N�-h�
9dR���� @?��w��ix�G������%�7�G/皆9|����"9Wʫ�L5�h3��ir1,&ĸgT���x�#��"hSptD���lD�>�"kL[)L�I�X�J����yS7����V��2�`C���'�LuN+���n�St��+�C���n  |�%��74^}��i602"�zڕ\��s���n�9��j�s5��1;��{�k��H�f��\jx)�b��]���=b^�ALh22�X��4��쨳��&��LóBu4k`�H	v���9o�f<��=��+DX�Y��&	�Hv�n+�mІJ� I�_T��P���[�����d@`0L-�z�3�����[��B���v��y����=m��b��A�BȄ�O�&��f� cG����V�M��g��M�sx��U�i�%�J�tEMLĜ[��ǩ_��jV&ZIH���..�ѻ�]?9's�N��w1HAj���/*  ����W����I@+������u"���7��d����ۏ�%R+�鑯P��O�k�  ���cE9&�i\���C�;ޙ�a�;ˉSn:>����X�&��s���,��d�D�,=���"+�75Wl�.)�RP��_V���h��[>9����=����1 �q c%3��,��;Vs����7�7W�/��yx�x����2�<�+�PQ�3T�Y�>O=1�|�ގwξ���]��̺x�٬� !�W���]��K:E	��7����iv��A����
�ߟo�߿��poXj������.�X�����&�s~��o��}8ᘰO��W?�w_�?��ݑ@W޲��   ��!��*T\Ì焙����{�#��J��f�+8p !ә�ۥ70���..x����O�5x}w��
 �!d�|^d���_���ʮY4Ɗ���$0Ig(f߅c�=�������.ه���PF���O���M������U�xp�-��b*�
S�Q���Q������q���,'k�.��@��k��du�4⡊(f�=�9���;�0j?`  ���Z>���E�
`��t
���UZ;<$&)��Iiv,_v,�V򓅟�'�p��du(�@���AR��]��*_����;����-ߤ�`���<$������}�/�β4�4�1�)H�X �3��H�KV�*� H�b����K��翻<p���X�G>�	P���V��u~ϥ5 ��N,�r�ͱ�ң��M�k�>�p�!���Hc����('�Gq�R������ߴ��Gjq9��-�0�J��^s����c��X5+3cL 	z#�;$3�3�'�\ �Q ����������1������f�udu ��/oe�;T&�`�`���!x&6��9����n�a�D9g0$�`��HyԯS��?u���;�8�v��7�� `RK��n=��k�b�4QX �� �&�<�+R���*�H��   
Dn�{��ǻ��`��I�ud��*��{T#����+�~"jH� ������b�w����%�M(Q�#�8�Q�D+L���G�ڟ����_�$��e��'� 0%&�y������ޚy�
� @  @ ��s$ho��c�y:=3��� �2�l<���Q��l��W���=�iN��K����ٶ`-�`*��:B�����hy��h?!�%�X�<$vH0� �`H��%[�}���/����D_a�
��m{��ۏ[���դS���A
,0It'fw(*���x<�>��f��u�,( �HX�h���\��ۂ�,�o� @�/.����9:�� 0 @�;fK������	��5�.�1a�c4�3T���X0 ��` ��G��{����A����۩��I#1>r�ǽ�>�Ӭ�,�tM*%���IX��=0��n�nX8Zԍ�P�z}�}�z��l�+W!"#�s��nc�ธ{Je�wܕ�w}��[
2iaŁA �z��k��z��ÿ�pdå���q�H
���#$�����`0�ژ��]��ҿ��N��5�N���������D{Ʀ.8p� ,Z#g�Q��`nר�ڡE�,޸��׺��)  d�B�,�kN�m�����P�k`�0�[T7��	��Y�c��G�: C}&�g�����ߜ����+'y>BY�P'�W"�~Z��F�B��� ��0׸�Ї�!��E�������wf�n#g״+6� �`���E1h$��Z�7f������D�~�uC�~m�������ӕ�(((P
��������0 [ �f�1ȭ�������t�0X8)2��̍�t���#����텧�P��|�9�|��B��r�5�l^��� @�T���r��?��?^����w�0ӨDJ�  �H��!Ʌ���b���Z0a�r���Q7$_y�ϼ���ᇳ�OY
�B �h�3o�����'z� �  �����G7��,.��ر�1X�,�s+��͡���;����>������;yN6��9a�J����cE7�tu�l�����&��G�x8�o/|��X�S0���" ƀ ��6F�LjX��@-�6//BC�/�C`�}��ʻ����1s�8kJT�P�4)�t�.��
��S#�{}a�6�������b&�1X5�y,\����-_�/�O����o���T��O��f�c�C�V�$J��y3q
+�AT�N��L�=����?^�_^����#FB�@B"@��dBB 4g�+��4C-Z�kh�ꇂ��A��µ||}�]>����p�8yJ�(cb  #3����!��I�j�BӴcǀ1d�C��������g��K��f���{���k�e��0C��	~�q� �@z�ټ|�l� ���������-�\�_n��"c�Lt1�1����Ġ��,͙�G����,$hQ?nB���\��f L���B��Ͼ��W��a���VI* ##�3�(cQoo�м�@�B�q>1��  ��ur��}#ސHy5 ]�}����ݾO��Ǟ�Ͷg�j���]�t��My�:��		�L�ú�$	Ĵ/ы#W%����0o|常���6m��-Ñ I�')Q$�D$aH�fu��1�XX��!�E��=��.^ay��A�� ���.�����������pV�e�� ���e�ۻ3�w  e  ؛�N�����Xb�X�$̬^��㝯�;��(�)���c�5�g�[�7w63��	���Xkm}g�lb�H���b�1 �U��l/z���ݶO��p�1�Xf�e)C���91A���7�ve��$E.K\k^��>m����e
�@6�sw��x_��o#�F �   D/g�	lF �+?Y�O��Yg�YhWk_,�MRqK&����_>���|��?��"�qF*�ij1;o���c���Okc}�Ĭ�VojM�*�$�`�~�u��<8�����.���	���2$eb��Y[�s�cv]��Q:r�H�%�ҏ#!�@u��g�_��N-^
 �  Q%mǽ`�lx5�f1<�n�S&uY ��%.���;��@�K_c��j�B�o�+������{��>��O�����֦J��r�L:R�=^z��=�}�;��6�βjG�"��
�#$P�l�2�j�ڵX�@"�: $/��\�2  ����6��"�����.�~�`�4k6��>� ?j>_��u����W�ת���w�6��*�b��A�U�k�7�6��.�d��8��2��T}�\��I7��'���9�{�c�M;;;����y�O����{��b����,]�!bΚa�Y��Z�9�{̮�u:$�r�"���s]�;�I (D(��Z���野������6   h+�b�
�}r�U���C�z�ΐ��\iNslwU�3Q��q�����Π�!�ήrL-���e�rG���]���I.�vq|�o�����k0h}��'_�~�?wyj�ҁ�:�$ɐk��,5r3����Z�Q�.�t4��\FP#�بK���`��F��%tQ��;�S����ɜ"X� 	Vu�ӈO�V��� �+�e�}�kǀ�Ng�I�ٝ���>��ާ��K^8��O��������ɿ�E��/r�}����l��n��ws����z3��̿=�G����3vu���]X�o���~~_��s���ɖ�v
� �A@k@� X2A�����=vׅ��$"�)rL��H�1#��x������x�Q���Ε& F��4���H��^]f�o[�	y�	����t�x`ǡ���6M�k�yt��ěo=�я~�y䑽�)�z�"��u�����{��w��;�p8��4�3w���n1���y`��\��3��3��ڴRa����!F��`� ��ij��V��u�Б�o�3��̜�G.]}���3K�f``��47��������B�c ���t"TYW���M? 7�+%�޽���nQ��f�N����<��8�p�F�K�|�a����7b�j� ��ct��ә���{�p����S�e���{wX���ǧ&�����I�W��A"�E"$Z�k�1\�E�r��+��E.��=:��yT�~�z�W/\�  �����s���ǁi^� (`:q��fAy�. +?D �7�G+UfZ@es�������b'L���b�un�g������g׍w^������cC wi�4T��%��f�&�5Z��0q���/ή��v�N�b�B3BlF�a��BGLK���q[��ՙdܦ���I.�!1+W�.�d�@�"���X����C�������X���c$�h�u����n���ã>���8rz��.;f<d5;VG���s�6ՉNq�bn·�9���th�Y���-�-SY�챩��zk�~|�ɷ�[+}m�R�� FUۿ�@�a���� �٢���s|�:��H#6S㌁&���Ӌ  �m5�6g���e��s�DX����ɴ�&�~�m7�[��g���l�����]&��t���p�o���|l��"�a�A��p���L͛�os��{�=�v�ӳ�}6C26#b�#�2 �@�K�%<a�$�S���c�z�=��0��0\ݹ������#AB7��#o���f)�`z�]��ufuD��y�<� ��׋>#�� \71̭gױb	L`̺α��h�-���Em [t}x���L.���7ծW�6gJ3I"���ޗ���(�y�*O�9�8�-[[sL�aΩ5b ��~���1�I���A�%jx����|��=
E�>�~�``�]>=� ��� ���<ilJm[��S:!�S(�����k��a�Z�Fm���h_U*�Jom���  h @Dh)A4 r�J;�cO�t@�C�i��^I�U����˻�"�h*���{�/IW%�.�HP�������W�G�c�9�,i� ��U�J�s� ��v[�𾩉D��܎�h氀9�A���b���u���Y�a%LƄE0f(,� �=���'N6��^t:�P`�K���;�<��_�����t�ҿ���Я��Iy>�K����Ef@ L��7|�SYcbN7���2J6ռM��u  p��� p�ܯ?������&@��l�n��w��b��<�0@�`-����9]�:�����-�a�00`P�D0�����=z̕���x�Gco�]�����nG��9��e4������l��)�T�g��`l1E�s�b�*�9�3+�3���k��:��?[��L/O�qN˫ ��R;���>f0�6�z,!����)�7�j6���b �0,w`�g��g7廎$�F;���ڣ[x�s�~�/;���4���ϣ^�5�xl�������'�겴�"02L0�J�����K/x�4��\f�y���G�l  ߝ��W��@ ���$�_�`���SD'b`k�9�9��5HD�1�P�����8�]':���P�0�<{>���|⛯K��Y�{˵�ud�����S�x�ů�o������屢�D!`L�T����w>�t'Y�M�Qyl��M��`�+��]Puk@E9 0����u�����b���! @q{���V��GC'�D"L1d?����Bl!=����b���W&"P��1�t�;;�I��������%)i	�tT��I�^���^;q�����>t��0D

�:�~i��+o���_�GT�
K:]���֠�¯� ���l��
 P
C9��bi�f0B�z�	(V��Ҵ>    }���mg�;z��e��hO����E�Yf�!�<�a*��+��6l8x�����?�,n/�(� �T>�b|)Ԟ���k���l�J@�K^g����
 �����sy� D BQ
��1t	��f�!��5y��$	�$�`�3,�����p��w(6L�4��1�s>�*�������v36+�D��LHFH&�ѡ],�{��WYP�C�Q�z�;��}a5��Ǿy�ɫ5_f�  ���������  |`�#s�2������Ãbc�a-�_vR��/�c1�f�^  �&�` X,X���膳������m� H���}����[��M�hJrLY�af
b�B}�#;w"mD=�pF������xf���Fn��ԵGG�!�RB�q���[0?ej�{A(�`FC3�8ǆ0� ��E������g�;>9���� ��KJA�`` ������{�piP9(�������j�zp�e�ewB�5�8& �L ����	9��-���8<�wL͎/�M��?�-��bs��f�� X 		s{ � �L(�iF����:ֲ�M ��O������=۪t��LZ�$	I$�$H @)�/�{Gj���	����c�}���|�ۧ��:Z�r��o b ̂ �y$��x
��u��(�0��o��m��/<e�Z�P�: ��8i �  �&@ے�AE@� c��c��XÀơC�  
 (L����5������U����?��/���C��=�d��*F�3[�c�1mr��S�ӟ$5O����w�f+��ȵ�0<�Y�!��P浇y3%  tO>�a�ڳl��6��N"�v����l~� �  �:��$%w�#p�<3�� �L��Zni�6֓��Z D�O�����+\>�G�n�_�g�_���~�w_�QUr*I`" ��&�<����
�UY���y�/���P�y$�E0��f\Úk% ���2�?YBHH0& ��_:��pNXf��~S/���k�c8�T�� �+.+bJ((T����[gC#$@AAP�?}q��x�ï�����{�����q���ʷ_W�W]2)Ů�[h�gM�����ɯh��\��.k�ML�-?y��Y�9��ά	 D���(9MdM�V�-df�c H���z�d0;��Wy��~�g���z� �'*a`� ��6�j��6����O��Ќ>у�u������p�`���&>�{���tO��쯃�d�AM���Cl�5h���䃱_���Ln؋z�٩/�M�u���pa�
�f�Y�� ar0 ��X���R�{�}���������棟��^ @���dl*Op�D:��%��M��'�PHr�9�=:���H���x�f�~���^����M���/�H�Ǟ�E�$�A�H)�XY���~���Z���������W1���D�̀E��	 A&��Z�  @�H>�;/iF����#�>�A��  ������   ��k���F��C*
�o�˃!qY 2��������)��S�����C��Z���� $�k�D�Q�$%M"�`R����vG�����77�ݳ�f(c�d��5 x�5|�Md3�c�dƞ���#�<�oή��������#�0 A��XG		��&�(�����@|�4&&���~�-�{p�*~�?�>�{�K�����Q D�+ʴLB�aЏ�N�A�	 H���h�ݞ͡���L$�bd����$g����[jp}tЄ ����+0�_z���߸fc�G   �yбQy�)�L��g�"U�(## ��s��(L�����\v��ߌ�篖�}�~�G��~0[ghR�$ `  k �� ��F�ÿ�Nm�v��zm�u/V�P�B0�00+L\� ���p���C��G�}�������߄Ŭ��Y<?�ʗ�q�qR<� �C�a��TK|D��	(����׸2�g��6��_5n��y�{�?4$���J)!�I!i"��" p���0���ߺ;�=涃���u|۰� �4���  � L�!�������#��h�������O�?�'��� 	� x P��$�RI���$HČ!�(�}�1 P������_�/�����οi>��� $�b@�
I�M @d   �F5Ќ�:���g��]G��ߍ�m��������#�,r�ofٗ `�a�G�/�W������ޟ�Eּ5��8~  �  ���`� (�!S�II�R	�	�&C"�1���������A�����?����/6�B��$��m�* � d�P0A�44e���2�G��_��.+|T�6�e��_��o���������Є��VB��)]���pΕo0�'����!���W�ɋr*y �^S�X V*/Ŭ�LIbJ%Vf0�1�t��X=�4�<g3�ݿ�x�o����		�� {�A��n�``���L�q����ޑQ٧(]\��:_�����������6�Pj"! -9�d�4� ڟ\o�`�m��|���~Wy���D���')V y��P��DJ�R*�"C"f�$ŎM�ș�����'��7�n��k��g�ݯ4OeH,�bC�d�7�J�1�_v�C���+�a���S�)��-F;{��^��*� `���Y+  ���a�(���w���7��C���� @�"Oҁ�L�d4���A��	%	J"���7c�`B�$RЌ�W���x?�>XM���O����W�?�~ �^  H0�$,9H&H� �,�a [h���f{�CwZ��0`-MWS��}������	�'�4���(�M��C׿i���%ĥv L�c ���;9�D� x  0� ��$f I��`bǞ�0�L�^]�	Ä�o�?�/��������8���r0 ��` �!U};#������ � r)p��:�#W��"h���\�Z�{Y�����|�;Ocւ ���B��(a�o}��/E���Kظ�U�Z3�H�
���K��(uƧ��&�I����f-i�Fkƾ�7����:�<��1!/L嵒l������b�3%n�JotdkyD�@��)��O�q,n�ą�������6g� @K���A PF	�7_��ӿ����K �*����(-��" ����{� ��aJ5l��5&f$���0�����}����?�~�N�<y�c�,V����k��=i�i2�` c����t�f-m.��)������w�+�|}����N��+�c�L��%'�@ ����`����S��T������� �1��
P� ���"(U��)01ؗ=���8��_����Sg���v yĈ�L��7�YHyx����K&&�l �?�>�.�eoOT��@�؊��3{����������
  �J %3��
+sc�`�(������& c0 � ��*~��sN�s�$Q �+&x>9�G^��;�ųG��B�
�� bB^�G�j������ZXEu$ 3#:����[7�u#�+ڤM������;�4+2�a�` �I�d	������DH  ��n�y��������1 �sP7#�f �� _�   ��B;P.3��eϜ���C��u���B�C��` @�<�)�	R������V���~�ě�`���1k5ː ��7��֡���Ƭa�mZǅ;�/��y��g�wՆ1e� 3`  , X��� @�-�< Cr�aʕ�� �`�`۽��z}\��\I�M0I�ʹ��h�;�^yxģ�k�q����)�c��S�y�i�����?����~���OW�1�������@�=�n
������X�E.�����W~�����kY	P� p�  C0`�O �0���Q`��<��x�=�ׄ�� �������f��93��)s�7��H�RY�ȃ=���ç�i��<$�#�jR��8����W����Ʈ�^7��ջ�_��O���p���fw�t'9�2��9�RpTbĊ6�b��������w��<탳�[�0�e�) �Yj`� `��`L��=g����<V,��0�ܥ��``a�v%�>)x��N��m9;�F��G��0�y�Ҡ� f��oh��?��7E��ٻqP9�?��s�������m]9r���kZ�Miw]�ݽ׳�Ç���ٴv��F3��}��� K�R`C�b � J��%ΐܷ�m��WwĈ|�`�� V�tNU�e   �F���r�i�O\L�3�o?��9�T�`0C�2?{1���Ϭ|�/��Ƹ�m>mx��],��_W��v���Dc�i�6�����[�>�|�+�a�Ph���$! F�,$�!`�6��-����y��C��o�<�4y%�D���:���8�Wh��nh��Q�T��hyN�k�p%�yg�ǡ�>�S\�;$� �������WΏOC1�*�8c�6f^־���p�����e��J��`�~s������j��� ����0̀�,3#�r릓8�A$D�PF+v�ab�����N~�yT/+V��g����pD�L�L�̑92G�E4�V:&Գ���D�9e�^#�	*v0�~N��X�yl5.������"i��Xh�_.mo�s��˚j�h����ݯ����I��AҊI�%��	2A H�d�3���"���B �-��G��a�5�<��_��<L�Q�3�"�'0��uJ���}��Qn(L�1��b,.F�q<p��a<�	fHH��$�N���P�A(h����F�،q�L�̨4�����k�|����IՄ  R��t ��Af`����Iy����hX�P���b ��*�034����YVR<`�i��c1���#�
� � �   8s!��	=��M���s�c�jn?0����4�������Gy~�tF�"
L5�D�E��i���o{�=���·^�z����LX� @��2 ��, lˎt�έ쭺B�����iH�P �`�*ΐ��ω������X���<�>y�N	�V3P� ���a!��kf���2��<���;S_G�	I���xg,bZ,�9��j �a��xw<M뼌�	O�ٯ��^��`l�� X��"2 �ڙtk�Q�k�ܻ;��)R���4�)��i �`�)��O|�s�S]`� (VbMϢ�%5�K  �p  ��T�z�Rb�11YW�c��8��PI��0�A����˛�  �0�)6h\�)��IO����ko���z@� �drɄQA�CÀU��.�[�VU���N�aN�RMCӘVi��Q
y�g����<�k�y���.�h&2�+zV�eH�vr̽.>D *��+�*��[G�Y7m���!���(��7a�5�0C�� �sD�}=�lF��� `��eB�\�j������{O:�|�A2�`8�j���q�0l�;ڭ�|kco�ʅH%�T.#M��jLS��+���D����qI�����j֙@�a�ɨ��u�/  ���9�Ez��`$	/o�W��`0&0�Bs��ܹ�&���W��<�А����X�DR��x��׋��o�}�٬��L�'d0���� &D%�e�Z����KQ�M�"�Qt�lŤr` D�eB��m�x�Ǐm|h*�9��]Cd7�6Of���
v�(�߲�{Ð�`L,�9�D�����u`FuB�01!/���ጡX���G�H��˞������]�]��� ���B��S��.����4�.щ4��T��~N�i���AV߬��&M��=������/.�UQ�1��S((2��x�� �[����HÑ���{�c�&����bQ��q蜷o���u�< � �HW*��\�jS�{�{�v�h`  �YJ)�A&`��ݠJ����GG�!
V46jGC*�F�؋<i>��WI�A�2Y�ƚ�_};�/��e&�9V y��cMf�� �DR��* ��-�,�X���8��-���Q�k�pƎQ�~0����^��^���-gC-91a�6$�J8r����X�]�����~\y	>��Ac���9�h����`�` @�}���\ԡ�;ͰA�'E y����e��#yŤ���U�hO���+0������Ǽq�װ�c����І$>��6"0ۧF߫�_��W�hkV��}2 `X,���+��U��Nv�vm]��-���w�7~9��xf�oF�!��A!&l^�������.}������}q�֥/� � 02�;^�� ؑ|3�tr:9  >j��cac��|9.�q�8o�{x�Tn�!q��1ao̮���~���rZn"�%JQ�y"4���x'��w�M[w,�9:�4���67�|������TD5�ys��}�%��Ɇ�viSe�{h�M�~
�E�G����ɇ������ˏ.ZL0x�Ȕ�z����O �,�~)�hi�׬�1D8U�I>�n�OZ�*$j��Hf�k���~�~ڣg�YMa2 ���[��0�+�K��M6�K���$�@5Fq
���xZ��N�͆O>}�&RI$��ȓڍ�����#�q|xȍ��ֿ�����_n<�I�c���(x �� ����ي�  ?���3V,�X�4�{"��ԗ�u��&���А� � @�xz�k���s>�����D2` ҷ����_p����Ή���1�1�T��Zyzo�(TS$E�����5���3���ژ?�yĈ�L �  @âv����h�̓����0����*�����f�|��ǔ�`IW
 l�g��g_���,6��j?�Ɉ�`f�F�����Y����FG�D�!�1�u�rU� �HnC09 ԓf��`ꕯ��/n|��Ƌ�� �$�@0����(w�	�f��ٚ�ʔ ���� � @R>�K:���/aux����ɉ�ǹk�M�-?�����	��0 ����a�Rv�Ӌ��~e��]��:ESMcL46�목�A
 (�2Ƅ���ǯ���?��3]  ��rD0��hA���jʫ�޹%��@{�y$�V�A 2Bw�gb������W�×dq%�K1t�N�T带1]�O����|��9�^���`H"	�b�&��ʅ�ٙlsz�1��ΣiT��C��yYZ�&ĥf((�A b0 ��GL��)���(�:��j����$u$E��z@� ��St�N8�[�� �9k�(15���Ad�r���1�>����ϧ�"9_��Ǉ���  `g}|��f���Y��## ��$�FR?\���a@hQ7}G��Q3�\�!  `�V�n22����:�#�I
%
�X�����< �2m!�  ���uͅT�SЄ��pf=F2z4�|�r��x��8��ٓǇ������K�eHF��ؤ�0� �d�Y�@��R>]�=�Gݔ�C��  #��&�ob��;�2�:<�5VC��P�ԑ&H��e�Y/.; ���7�TswA[��7�PC��)����U�u���������g���)4�b\�'��W�'ǋf�Bŀ�`BE%26͙�+0z��EX98����G�h1/Z�߻4@�ʃ��8���#O�1���,�� (#�X�!���,@O�X�@W��	�r�i�1�T.2o����7.ə�����_�ĵև3|]���5��Þ���Ӧ5��`,0J4��g�3�GVf�.N�1���K��-F���G݄���;�wy0&�����|��_e�/�_ 	T5�I��Xe  �:   X�΃{��U���pm0>x�+��6��y��G�����ۑ�㝯��1N�� ��DI��\]q�6z|��l��iB\�ƕ�۰ ,��_����"P���b���<�r*��rn<�[�����m ���47m��Ţ��{�#W�	 f�Ͷv�@��k(���c��qdx�����oϼ�W/o���Ԝ�NP� J�K�\=#��,�4W0L�sW;���x��1��o�շl�fB�(�7�R:@9v0 ���/���׾���?\_T �J�$�͞�V�)���0��w�2첡����|xT\;��g�����������H;���
  �J�+G��еYޜ�!^Be�SV����O*�^�	����S�K0b0 `��<�1�u�!��W����|�`����
  6�����q��5 �oΡ�
���� d��fT�t�z���2;�K!� @4kf�h��^��+,�O:C4�zԍ�Q7ژ��z�7��
O��kW~�S�/ #(QƊ1&�` �`0��u���������/�hbL� �x��� �<��`Y߈
���m'�K<d���'i?{�4�Nt��!�$�,�\�_��*K��NR��j��҅�R;t���o}��?���G�-W�r囟B{�JH&@"��$�9z�/z�x���<����q(0+��3e�eb �`U9s ��١��E���2@C�>��+,��#ƕ���9˧dK�'f����C��Q;��J�-*C�����z{���U�y�O}ʚ75`L�!CbG�#+>e�x��K������a5 "�o��
�1��k�U掝�>`��}�{Q�
F��=ɮ�뙯tE
0�4�8a�÷��f��w�S������4� qx���GtS�O��M+$P�&�Cr������}��m~�Ô���U0X(#��bb�B�#Q���,�j����ˉi
[��'3� �buE��H3�sGt��K$��.�5��$����!�K��5C�b �s Lʣ��i����O��!)G�)�Ms�q>�!�v�ǯ�ËĀ 0���� �`L:���O*V���ى�p����we.N��1fϱ�+� Hfc`������t{fOY��ᙑ�	1��]��W��Уv�( &gĐ`0 ƙ�އ���o��B�LH �鉣�y�����f��k�O��"0 V$�XH � ��dI�����

� ���'�,���:r��Gm0|�82Q����1k�m2t��C:�4�V��d<�6s�!cNh�X^K���+3����T<��@i +V�8c��N:9zw?x��[��v���=�Gv�cCO������5��cR���c�����Bu`�.�^ҟ3u�X �1�b��>'�&��IuO�ST�NX=`d���30��0 �dLAt��.�uve�M�ɽl�U���,�p횿z�w\�2�����m�1T\��^g���{��S�Σ�躵^�m0S��8#N�x"�9ҋ��X�c�Q"q�]�7]pa���t�w?  �<�5oE8���e�ZرTTO��"���������Ĩ�@2&79�+���o���1j�Oo�qd|;��7��m�`L�4QW�I���a�L/�f��?�?��huG��� X)�[#� H�P|��z~]�:��`:}۳�B`�E�&@k�'to���F�l�m8��,���U�Q��S�N2�Ѓ��C͓C�RSrO����(�v��p�T��db��댛�J]dO�k�4�u��_��%e]D�D�L�3�Lj+� �y���i� =u��=��o�N���F:}͋�w�ȡI���t�Fq��}w4͍A��.^p���bF��{R���2d�0�;5O�$�  ��#f��@9QGT�DHbŞ�g����`JSS*�  DR5{~)�õL-3YD� ������D.���U�v�����Tn��<�#������?y�>���񦬲��C�;�!� R2��   c��E���#�bO�4�X�iy�Ť2SK���W�[��ٵ�WK� �R��6� f�<���]zEz�5���ץ�ݼ���~�?��BDeMy' r�M�t�Z��c��9��ӯ  ��� � 	��`H �<bR�t�Z�*1LJ�QD�p��]tw��.� ]ђ�Y�֚��7�A�"a��.�ac��#�6?���Zw�����s]�.��!P�(�ב>�Vtq��� �!b0dF�R@ `�Y
��H����#Hq���<��b�L����R�N?�q��!?,:@b  k�R^�*����K���u����ܳ�X:��ҩW/����t B� ����]`�Y��2�M
*.0��@ �"��b  I���`������YWy��"^?T��5. h 5@$̑=r��nZ��:/����������P��0�>��@  ���f]��������E�"�<QAICR�t � x�~c%E��k�_���&��@q`{  8%��|�"@����G�^L�����������pŷUPC�B� �w�� �Kp�<gd�.[<a�H"!�<V��	�ؓ{bRMŤx ����g��_g_6�����L�: � �Z  M�0o�AG^�n��ir�[P�qŷ���2 #� F T5  �`�e�|��s�1F&Ұ ڠ�+�� ��$%	��
���]vGζ�[#��`���r�i`��� @�XM �60M�-�]���Ʈ��9`r�gG9� F0Z�u��nA  ��p�;F&���:n�vêSn��{C�XKT��r,�*ֈ�
y��M,�,�"re*�����@�5QvG����n�R\��  ����[������ p��ՐA
L��s;{U�#   O����!�i�"�%��OH$
D���4��[uIU�� =ž �-)��� m ���[�^�m ����3/ `����
���� � mS�*  �� ����Q��)l�' ����� �US����_��d�0�W 4��^ �\�YMݼ P �$  sK"=�&r���[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bkq0b4ww0tpbb"
path="res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=["res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"]

[params]

compress/mode=0
compress/high_quality=false
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
Z����lGST2   �   �      ����               � �        ({  RIFF {  WEBPVP8L{  /��,͘i�Fmϙ?ᑈ����q����m�_�_�ڶ���>�?�lIR���'��A��@�$0���+��l`� ��F �  8Ҷi���~1�`�у%+��m;$i۶�8�@�\Y]]���xl۶m۶m̌�m�n]��2����X:��(>bҶm��H��~��J�b�Qw{�8�=��z�ffsT�_���ҶI�_��۶C��m��HV����ힶm۶mϹ<���f۞󱟶Q�rUf����$�����YoЭm��H��|�~I挈̈H����Y����xks΢7gw13sswAfArd�f��^c+�r�׭mki۶m�)�IU3��033��g�Ye~�����$��=I�-ے$IH�1���e兔,���m��ֶmݒ,3��p�23sݪ���j��N�]u���k�ǉ���@ �8����v�7x��mm$۶���%��Έd(����y.ff^�����2"���m˒c�K�-I�#ɶm��{DVU��X`���������`|&��U	"�Է$I�$I��$�3����Y���B9 ʨq� �xpm�N  ��lH��  	F"XQ$�:�`��!)  ������ p�  �J�M  ��pMu3�F6��19%��b�ܖ���{����~����/� ���a��T�����%W �m q �A�� �X�z  �P�X���n����]hA�k�O
 ���	p�W����Sγ � ����՟��s���]qt eS��b���W�I�2���H�"}�����  ~tc�d�|�f� �AL�Y0ʠ���*�
 d`�` ��.� \�8 ��h �Z#�a� �ʗ���O��e���'�����{Ln�3�jA p����(@��e�Ӏ@4@L�h���e�gY��k6�|!�r!9��\
t!x� RbX� ��A��� ���"p	��8'����, h0+�@ `_�f ���i~����K��g�u�X6�ŕ��&v�4v�d;W\3����>h�J�_H@�@��p������f�Z��\��
�'g�df�>!�NHVu�HJ)(��ƫʫZT�r��EW���ij3��p��ut���	N��\�!�1���� �x1���B��.���fO�z�.��oڷz�~ͷ<T?����[���P��+����& �K���d	 `���X�}�ֶ݊����Dw�i�E;)y���B.
�"c<y����@` 111   ��,-&�<ps}vk@��;w�GZ�M��  L  hK	�?� ^��79��h<�3����=qd)����'��{z�293H�o�_�t  �p� ��}�	 ���i  $`,��?3�n����Nu���U��Ln���`D�q �Ad q  0Gb��
��s�HE���r�Z�v�Mu��������\  K	 @�~}��xF�B%>[|b���#��crf���f{t$�ݭ$�N�K ��	�#ޑ� M������iu0u3M]S+E+�fn��!�)��� C�����   
�c�� ��* :����� C�T��\�ټ�:�t�v�/�;�ݱ��.8�5܁=   � J���;o�?�6�Ѭ���Zy�b�޲^���=}P�*�G�ɶ���[	�t����柪Bz�p�����l�� ���r ����ֽ�8��F�C��`��-� Р� ̑1�� ��1�D �� � 20 �� �K<�8N�Ĉ7�����.u����~(q   �RR6�7b��������\9���{�����L����S9'���ZMO����������R�6�Te�OU �z~A��!�� ��&  �)p<q�;68����IƮB��
������ &c$� �� �� @
`B�Q�A�q�<qD怢E�X����l;nl��w��.>�O�� �C���Tvo�?��o{��{���T1��ܵ�Q�<w՞$��ғ�s7���*A%(A� \5o���6  ��KFe4U�4���*�g�`r��C�� 0ʪUf]�H��Ppd(&td �  ��1 B1��(1�B\���`Q���DUO펛��L�X��䴺��W2��-�)���c�ssO-���;�rc��U�(uGAw��3I�D*#�2(C�R(_y������1��dg�@ʛ����{����F��B�#��vHL,8� �IQ0 D�1��b����XA$�d�G �� �1J(���/>8q2+�ͶID b���Z�=zɭ����ͥq/�|��ld�TZ��΍��^<�W��{%G3C�N7aa���lB1Jك����P�2T�e(C����c���-g��3� ���?y�½�qa���<����Bα�L*�9�Ӓ�xq�L"� ���u`V�L+/�# Ld(0&�1 D�1�]X���~H�9$&�V[��������v�}��{����������G�4���Q��E}��.��(ܥ�.]�LTʬ�!����o�˻a�Y	D ��X/[>iGg��L�d-��x`�p?��98cƈ$rb�&��Ą� ���up� �� 240&��
 ��#��"��s�x�r�!5t ���Vp�ꗵn����G����O�aw�Y��{��A�8	���I`�D˖^)12SMY*T*%�"Ƞt����?�#  �>([ΐ+�ֶ�ߏeWS/��iMFM9�l,g#t��s<�7�c��*�x'NR��x��11�s"ƌ�1�3$n>����$@H�F�@0�ch 	`�;N�	�<�� cX�|I|p��Zz���{%��GTF��#�Ă�U,�ܝ4&qrF�P�Aҫ}�0���l2# <" �A�rl�����u�!7z�B�P1���A��_ϭ'vW:��u>?�7S�a�崘t�8u Ƙ8q�KbZL�I�/�/���31P	RsB�
*(FJRB)3�	%����AL���!-���8�§؟�?>�Mr������8z$1y,�7!Y�d7dc3�T�r�ՠ5�C��,$W;�k��M�V)h�/�L\�!]=Gw�ƕ	MeB�,�9�K!���';G&�uLb�3�'��Y�8SM�a<���d&a��e��K�a"�7�!=&�tK���ra>�N�:�1�$�%)��	 C���O�s�T�(��	{��4�_��|����=
�A��`�#��̚;I�Z��RU�AJP��
\��,��  xS�Mf�������I�Fj����
�Mj"�<�3�_N�DR2�f\�>qi��2,e>2]2��R��"J�`�eB�� ����8p�~N�q����V�5ӝt��ݤ�:����ZQ�'3O�L�)�lA���Q>ȇ|(�+-Y���ܻG혐hB�P��
I�A�����	� �y��,�U�d7�b#�>���= #���EH��R� ��µ��$<�29�:3#gp,{�99q�r��%J�K"p��q3�1D�E%@��/d2dRfh�I����o��̥cv�s"���0S;L$�`�0;e�'⁎�򃪌�FvFv���m䋔,���[O_����xH�4U� ��j�^^�a��\	k��z�����O�@-�1Q� ��
 cEL��&0.t�l��]su�-��s��#��6g=<�?�+��Қ���s\b�� �1%��P �Ԥ�,e&KN�/��_x�vv��x̍[6�$���H�`�ˤ?R�ٕٕ��l�C��"���Dw���������̈�^�  \�)�p�NXT���wE�E�:�� � 	`��ݑֈ�����`�)�9�u6=��/q�0  �։"1  c @fe��&#R�Zj�E($dI��#Տ���<�޸0�]'9��ϑ�7��+^b���3�	��A#�f\w��W�+��֨�G�*g�r����7��T�����V�m�q=K0"�X�   �  b�H�$Z�d�2/��/9ӕ�y��8���n�np@�)�ccXX�:�Ս @��d6�,����828����o�K:&<20٘O\I$	1�`E 0�Z ��KQ
h��m��c���s�^�P�k\H�t����N���n��go|֮�/�&^ �@ #D1�� N�08�;e�'?��]��?��dPZ�u�=����7�x|���� D����2cVA�   4LC�4.�9� ?�|J8':�[�2ņ��,$�H,P(�Ȃ[d�9��.h�U"��|��;�Ƨ6�=?�V\�|�/K���:��p< P�� `��}xٳ�������H J�cE�A��A�LgIgM:2���/ߕ�}���m�l�Ӛq�$���	����c_�^�����?��8�p�ֱ1�u  8���c  X'
)g�Hw�v���L%Lb�C��� �H8�&Z$؅C1�pA���,��P�{���}_�Wo���yE/��UX �o'�I�o�lĚ;���h</"0��� 0�q %�H��1Ks���g��/�>Q�s\�8�����D�a���;��z����)·pN2�<��2:M�8��h�,��3epK�8�A(�8` �l8(
�`������z����xc�z8�{uX(���x� M8����t$0#�����I����da�<�|��/�/7��W�	1F��u 5lh�{;�Ǿxt�%��o�y���!�(��z_D@ g�9��\�3�fh�9^�$�D������P��r�(r�,�	Ey   
��M��h��;�����0���Y(W�a��C>y�;����7	` J��c��qN4N���:?��oy����fs�&��A�B��� G��=�?�b��ޟ�?��!,'�ƭ��1� ��ި @DzG���~�^�y�I&�(I���/\11pM�����D4���B�B�M0 hh�nw���m��y�ð*]tq�|� �+y�@���̓>d�����uZ�9 �  �"1P�C��4,���s��?��q��8��D�Ɗ�J�	��&;���2�~��aGK�<l1h�� Q�����|�u�n�+���#��KL+
 E�� ��~ŭ�;A@fj�a����Խ6����F��e��.ڸD�%�
 �R�����o���[Oz��qa�
0L  @ k ����q�b�I��Oy¸�������& ͪ�"B(�P�hF���}�������&��C/�����a�Ƙ�4@Q��:���t7���ީ�49x��J=�<8 	 PT�RL�I�<�	ӅY��0A���

�0�[v�����Z���?g��;&���24�ށ�]���H�� X�DbE�0����qd��h<���p:����8n� ��*Oa 
B� �h��q�<џ���/���N�����	�[[�� � n�W?��5z��/�ftI����0  � P	ӝ �O�Od�cv�g�t̚��$M��
 � ���r��>{瓯ݙ�sg��l�����w_SC$f�y�Vl��쩇�uD�d�AeOb�Q+��횵�|�W�^�Əw3I�`���A(�P@ �Esr~�����?�i����O/�''F @H�����~i��ۋ7ϝ�l��CY��A�[���<i�V�Ӥ�\���ϥ�%*�#$�  0�`.2��zo���WsI���	  ��đ"y0�ތ4O�;[:h�s���X�!I@��4J�a��۾}�lG����Q ��9є�	�  ����O��?��w�O��/�_�'G����W�7�yn���y�OVE)Q ��\�,+G�4'��$�*z
�S�JZ�Nz�N>S�@E���(�W׶��+6��9��O ���\
x�O>�V�������{q�����Hh����U���۴����D�XLi�#9�Bs�B4B����P`�K��?ݏ?��}|7�[q�K5��TO�}v�׮g�޽-w�2B�   (,� Gw�jL�yj[s1��Rf0���\���d�3?NU(���� �Dj�_z6U�'�C>�Q$�,\J���1k�(���糷�����A �(p2Bi�������������g�*2���H�l��k�x�D#1��!�|/�����?&>=~X<���;���>�vg��œf(4Q�D(�

P�ִ�Cz2y�L�+�4�c@�� ���f�U^/�GRf�HYĈ��� wOwN��t�^}_ΓAY �.���ɍ��ks�g ������|:�=����������n~�;�F*���P�x�)�u֕�8�I�P Ā(�7�o_��?����w��Ӟ����7������C��I�� ��b׶�j�&ƺC"h{r!�#S�b2e�����.���| �  � ƈ"�x��7z'+O>�*��� �|��'d �ᆹiv]ll���g�3O�#bD D&aQ�^[�/_��ɾ���UU��HYdtdF��X;�^8h�;� n!���2~����7���=�Y��6W����T�
��� X�ñ�]kb�Lc]�{��m � �5/���|�[�rN6S h���Cҵ�����^�{@{h� zrA~}���u�
�ܭ�3v�S�g�3�X`"�X��4������ߴ���a�D�"����P�)�a�������=��  qK/6J��y�|����~�ۨ�ޭ�l��e�B!�j.� �AVYM�>�,��֚E��i���� � �g�Ys�k�.D�n'�a  �.�w���r�w�Qu ���2�'d��9�fxa�>FV+�@(f p�!��ٛ��q�2��$f*�A�E?���h6�ݨ�������	�4��z����������f�}h[G!e����f  e@hQ������u�|*3��!�E�@�� �����O�.e�[�� 0@��Į+$���-�x)���2.z�ߒ���+�!&4����{��O@��884@RU^��Η�^.hqYy�Y]i�E=�f9�e3����������8�ۀXX�#zϺr���ꛛ7�G�ə�P e6B � 9v�6��"՚�<�i@�`�B1i^f�63f��|�M�l��4��(X���lt֦?y���r��6��  ��X}'��u<�1G �1�$Ȋ�������}u2kS
�RY4�a�y�afGr�����;��� &B��^�O�����������Yb�ĬD	P  �v��^�cM��BH�DLr�"�1�H*x0�D͝�΍A~<� P  HLd�xX�,��?�si�F��s�E��y�J��wd��n�e]�"c�@"��P�G�F���]�������4�7��D=ut
� �	��=˂�و<�>4���tL�A; ���}Lѽ�t�yk�f{לk�d X��ʲLF���F�]�^��b�|��B��4h�IG��� ���e�w�����#n&�i�P 0 ���g/�ס��5:  �����G��#�I+�G2�i\ZCc"AF�KC����m�WeU5RD �hJt
���ˀY{4,۲�y�/�}ZZAh���{�>=]�=���ju�y�Z���LV ,# Mlc�TS1��kE���R͍ r��c(+d�A���9� ׿b�S�b��Ad :�+a�#Փ����>S[ )I���M>j�F�G���:����@ ��� J��x��{u�?c�Q�K��d���9�2!���fg�l��My׺�_�mz 1 RT�r���ܝ���\��>�k� �2Y�l
�����b�Vk��[K�h{� 2'B5 8h� `��2�;�d�?�3�=�$c ��i�K��������UN*�2����o��F</��6�W/?�?�i""b>��@���t�W7��p�7FD��@D�)ȩ=s�@X6�l�	�]��_��t �@�z������������fw�k���/���X$A��:l�"R���z�KZ�!e�XXhNScs(�!� �ZΘc&�v~!Y';�
 �A  � @s�n�z�.P�`�HvP�S��ǝL�0� >$K���u_�<?vǄTS%��2�P`��_�r�]�e�g��uY��}���6b�x?��=;��C�i�ַ6�f�=�	� AN�I@
�!�2��ֺ]�|SL����$����lʜh$�pHM�4@d�Q� �|f�~{n�I�L���d(0 `,�V�lœ'� \ �˹�������V~O���O�<�� ��!	��Û��3Ȝ���r�KH([ق�S7���0@f�\�ʭo�/�kU������=9��۾Yޭﶇ $	{��$H���A��bݶB�9MM�E!!$�" �Ab@�1��t@4b�L�d¼��l4�1y��z��82M�a=�2o��p�6#�2��^,|��V 	`� �D�}�[���\&�"�|.�uYc�5�f�-���lܛd�,[W,W*) f\�Z?�}Q}������ǧt�~����YrX�
�A X��"'`�:۴e#{�d5t��D�(� M�H�! @ A d�|�/׏�+g�x�*�y���t7���$ ��������� ���{�W�xNì/9�d�)����\�ޞ��y��x`a�����kv�EW˃����Q�W�(o�mƖ��`R*�*F�J�T���+k�~��_�j<Y͏�j�j}�9j��z�1�@� ���rA����U��M@{ɕ2W��pG��ԣ 2 8��1e*�ا�5o�j&o�Ҁ ��"QR	G��r�����q�=W`dhS7�S�rJ
;Ov>���q�fQ��P���)�-u]]3Z�IDd
RΟ8�D��=���7?z��!��7˛�]�tAf#z�e�a��ld���&%Mn�S&Q�y��l=;�3� �Y ��ed����l>���Y�#`(  �!��L��+u��5)�������-���. ����5��ⱳ�;n�$�
J(zr��x�a�N<�����!��|1��le�XŪ8E��vi�V7���.E+Nʑ�Q[�=����ߟ쿿�x��+�-o�ެn��끀�� `6cO0{�ZZe�huo_3�=-
1�2�
�gSϤ5'@AZs��Q�1���O�5oq\O��*td #���h�~}׺ǻV��ù�]����,�bY�$/˃y�7�q��i�������|،��}X|�������ǿ����N��;���qӿ~z���|���&��5���M�#7�z��n�4����=|�{���{����}���>4K�$   ��!b�Ԛ��.����,Z�)�P ���L�Xh�2W}�ؘ1�(g�c���g����  �NU�!1��P�B���!��4!ߍ��9� �gm�e�L���E)f�q/.D��`��ʅ�p�>ӟ����+>�R�X��g~\>ڭ��r�M�5̉�΋���ƽIv#_�����-�N�ٚ[߭�vm�0  ,X� ���u0vAj���r����vC:��Bs�[m�zarR�Fh�;� �s0��3s���ϲ�LwjB � �$5�˄N�g�j)�V�}A9O�k)X���[o�T�$M�#��~�.�BM9��x���?%���cP����q���o��n��֎y�5|�F�� ��"U8Z[�ͻ�ǎx��q���ny�>��a �F���1� ����6[�]�tK�m�)T��+eȦ��#� ������(��EIs  ��\��"�䨧��  �ʃD�@X�4��	s����@��s�7��  �ym���^3O��tI;�t����r�>���p63�����뿹t�����#�圓+'Z�{�m���u��.r�וγ���EZͯ=��긶\_�lk�ݡ���� $H@��BP�\L��pE7��鳳�.:	�[e���Wƴ-��,?�B" @ PgB\�N쌙�� �'�AbQY(1� �o�Ú�ay��6��G��&  ��e��X�.�[���dr�����=�L=�i���}�!ݏ��2�y$��c�E7y���ɲY0�����;�!����[���0�t��2�3�"V ,  1�:�l{�[��4ݼ��R�Wb�}����N�^�Գ1�/ @�v�2��=yO>�	PN�9��!N�%Jr���������}  >���ixo8� ��Y<�<,�=	3Y�3���S��,�ޘO����w�8GbH�L<tU7�N�f��,���bv����qEWc]V��i(TMi �e�YF&"�a��� �l�co��`2��,�$ 9Wr`��M=��h�e��� �:�O �9J$�L�����|BO6��r&Γ�Qn� )���5�Ҿ�y���3|��>�7)��W[���Ɣ����-�ی���J6GFr��h!ގ+���#M�r��<qͶ�XH19ܻ5������];+��0ޤ0 0�ed�-�"�Ml�ѵ��{�O���Q�:Կ�� aR�� � 8Q4'�)�5�(�m�3F�,������s����<�J�ơ�5�	�^S����)9�	^P�Od~|�J�Z�{��;�&k��<������|��x$t3��u��#ގk\  � 48�����)�,2�mv�ົ_�O��E��Me	.�a<�^2l0�� ���p�y_������3�M�v�� ���!@x��LO���x�@�/�YY�Ex���7g9��?h��}�C�I�e̾Qwh�Y7��8{��h�������f�3�d����I����H�:���`����4��+��'�����@զ���!��*K��  �z �=8�ҁ� ���;��ۿ;��:ծXEР��D��I=b_��hN���^<�����G&�|���,s9�V3��f�%��HVЇ5	Ҁ�h7�������Y�����.�<9�=�gV�ć�������y�9Y�El?�9"N�L��h�x�J;��<��:�Q���Ő� @�H0 �l}��A�fd�W��ݫ_<���?�M�ku�� �F"��F�u�3D�:���j�ɏc�/�*�ږ��DLoa������ZY1�FMH�eM�G_N���0�E�~6[>>9�H;$�@b�Dr�xL���V�D ���L�P?���!��)�kB8 ,�K b ��l�pPf˱;|���ݟ{���|w��A'!�1��L��r��k�v�n.�%� D��xt��W�}����r>���$�j<c'�4WfFJ:�O������4	 ���q�:'(fx+|| ��j�ץƳc�h�D!"&   ��Ma���[=���  3 Lb  1����]��ƺm����-,�ޞ-��� �1<� b��  H�qs��/>������]�� �J��D�Q������?7�ktu���{�᝽l7�y��|A c�p  (� 'N]G|p�.l�!n�2D�(Je�;��>
0��  0��f��Z����C�7r����3\a�;+  @a
���2�2\u3_�y���=��X� ���`�E
�V���f�Q-��5����w������;yXZ�)K�k����%�V��;ͧ���h�  �u�n+��ຫ��,��UQ����D�(@ 8���i~{�� u6��p+[ٺTM0��Ta�ٙ銭c�b˰�� � ��C X8畚S;5���y��� ���`��P   ����<�آ]�* i>�;eD�-����;yXٟ��8��w����A��:�|?��n���_���m�?�Cؠ=l04�0�u�z�.uyt��U*�'ô`  Ze��������IP���{yŋn��k��  ���IrN|r�l�Za�X`@P���H �l���)��dJ2�ɀL�0���`����4��o�{�7�X�(��s<� �hy��?�_VymՓ
�Eh�������e~q���~��Y�������m `XO���ml�;�7&�Y��y��xe@�]��{�� �o�皊   �Noj��H�H hN�w�!��5�S,h	+�����X�$ � �C{��"

20 D" 01 @
 ��/�\2��
K��C�FK� P(r6B���2;���W����|�J��,ݬ[T�F�܍��g������ӧߋ�m���}(��� `��|�����s�/��|�5M�D�I#�a���c�]  Epo�Dm!
 #h 
������3Ղ-��JQ"�K
��n�$"  2�), ���D@a�.m�ۈ��mB���T(��L�!x�2}ܓ{On��緾��ZӒJ8G�m�m�ؼz������������r���ն��PW���f� ��?��U~���7�og�{	�����S�Z5٪��2ˏ
�2���;�}��H�xd��S��x��z�[�� i|F�ޭB[�R��Z���6���5�2�a�,�� ��쇶�tz��E��(���
��b��޻��կ�f���}zա*GCIE�@VKM^�R������6��j_<�o.��_d�`T�-*@����8��~|��do����� �Q�#�A���6�F�u����깵8��(02  ��$6��[��)�,��@@  ��W�� ,Q�H f� 6 @ `�h��@H������ؕ��h��C 
�h��������<���W�F�*�L��!�B�ѡA׺H1������>y��M3��\J{� ��#n��Ӈ/�=���/k����fPt��G���> �2
��9/�z�� �uA0�&�'�0��@0�c�0��P�%�2 :�A� �r\�[��ʑ��J����#�&���S=v����ޞvQ�� p  Ka#�CF��_�X�m�m�n�a���N `��|�c�����c�y��Q�t  �s'����Q���n9S  X����o��  @ P"'����t��� �9
�n)�~�R`N�&H8�Y0,`�z�:�c.6��� lʜ8���~?�M����⵳�1�h ���BH��� ��6���r)�{͕�:��0i�����Gc�ߔ~���_Z\��fW��y��SX� Og��F�z�V ��   HI*�<;s�����1 �
1 p���ɪ�T��00�pE���s#  .�2��n��v�  ��\�Lћ�~���(_._��,�2*Ib&�À,�0r�3��.Z�g�L��$*;�Ԕ�q�˗~�����������wr�ȓ�Hk��EW�� �u��1���@D�"F�$����`=��C��1�A{
̄��_�sx�#�G�������'b# ی0:]�56�ޔg�JAPhL�W��<-V?;vG��fy�hՒ�R`0 �� +�ȋ�9�'{�@/	Ny]��8�q��o��_聯4�o�3���NSc��ߋ��y/����GMH���$u$&��dFc�ˬJ ��N�⎃�x�q���\�\�X�� 	.�,@P��gX���eݢ�DaB�r9����l5z�|��i�qI
�`�@���9�9 �'UU?@�;�����K������͏׌�UV�>0�&�����G	.A� ~�U��^�bd$�  � ��*s�0��0X��LVi>�%�|\GƋ�R�|��Ҽ²��Da"�L�"�� VgX��=9?W6������L4q�z���_���z��~X��P�0�Sn{Y�0  Jt
 \�U }�ȏ�=�a��7��~�����ןr��v��[5 @�H�?CN����[    �����\$�:  @L��#��,�1+G��e !��4w~����=��|l�o���O�������=�DF�l��  0V�4m�7m�D�^ir�6y��������rq�0.�B�I0K1 lf�ܙL T `=��8��O�w�������׼~���R槃-�A*�  P-d�j�����-  ��o�)�1�@ĉ/U2\��	� _P���7>>Vd�K�������/������W�`�a���hd("���y(��+ ��W^{��Kko.No
UE:d� 62`)�A�:)A	����._���w_�C�;�O����vl׎e�L�>��  ]���Em�6�  �t׵D(	 PD"�BN�Hc��of\G`
'_������ߞ��)��+��~˟�������6�+�U� r�Md#�E �zA(�K-r�P(�@bRy�������^L/����b�`� �M<Æ#�  �e�6J2�0N�������O�����x����ɏ���z�c��  i���\���K��_  �T���� �x1�3ÅrA�J#�O~�_��Q�7��O��F���m����V���}�Ӝ�K�x��3�:d#3�lY��`6�JPB�{��cc���z5����@���_��=�e����E+�`I Hb�DI@��X���&�N1��)�����%��f���>��x��/�Ҏh�v69>�q	��B�/�:�=  �"�%����D�w\�<���ҹ0	�ox���O?|�����_��iվP�V~��߈� a�Iyس�����	����g�a�lΧV6P���>�����?���5؀a��m�CHl0\$��01@Pe�^�`O \G�o���ŷ_��b���O�����
4ۙW�0 @�T����K8fJ�I�A`�� /%L�@  J�4�d�����x��|��ҷ���7K�s�?|�����,�b��
*H&�L���J �+b�Ξ�o����t9k�����Ϟ��톛�+V !d�G�m#)3� @�0��ą�xZ��+����O��������o�.b����S��R(  ��JJ��"5���,ȡ� ��D ��e� �(��.��6|��_�?|�T���_Z��m�����W\����Q&��d�BR�@  2a��޻�_�{�����4]��_̯��V�]�A��� �$�`$$G@ H�srd�^�2�<p�D��WZ�x���v����|W����-�҅* @.ݼ�`:G�
��rX*����b�bM�d}Ĉ td"�q���Y;�����8�����'��7����������/�*�m�E�$"�/[X�� �� PfSfR��0�pgyv����ލN�}{��bU.�Q�  I���� 	�� $� �0�����:]����7����������V�=��\�"g�  �̥�rU��R�U Ke5!��s���|IH0� Ќ��������F�����_�����������X��* ��ׅ�[�G�J=�����ѡ��ӏo����rUn�t���Q)JAphxx , �	9�`�f8� ��!�u��ۨ��K�V��/���o�OHs����8��H � A��t)� �/��
�
B%X��KG �	Lpj�
�p�����{^�S�����������m�v��+�-�{� � $d�F8l{W�L0'p�k�-:�M�F��2c��%�V����O�Q(<	@0ɰ�Y�a0` @f4ha+I��0�6��>�ć+����ז������ݯ|z����HϠ � ���2S P1�@�"�"�D05L��SϏ����~;�+~�g�?�������~�S_�b��t~�D�v�F��l"`)�# @=  �AgP�	5^�j]������4�i9�
���)���#�`6 �l�p�G�`�� ͫ��l�����S�����s��z�  A��&� 1�D�XD H֗\�2   @��跣�{�����S��b������_�ċ�4�lxG ̞ٶV���� H �p`� #g�2���lm滛Q#��ތtTU�i�$C0� 0��~O���V@��'?�6�q9}���ú�V�ù(i�h�*���@U,
fh\w� b���1  m�=��~�o�;})��K/�����w�~+�7�q@�z,�֧�)S "<�' �� �a�� 3lf\�%ʱ�������R֖�դWf󱙪** I H@��`@��Щ����\>�'�}��+�]��ڟl�z��_��xJ[ ��7&��H ��
�ȥ	H�H�	A��A�  =�����}���O���/��w���ž�ilGZ ��),L$���7|����o2²k��K�;����7�~��^�i-��P��f�����n9� xL����y�|z������������i޾b_z�8D*����jQ!�H  ���+P�`DTj��1���P�hK�}���������������?���,6<  �@��ʕ9�����D@!�	��h����j6�<-3R$U걋��cg�u�֝�=n2$I6B��FPS��P@��D&w:��x���7��_���~۟>�b(�1�!��UC�TH ʀ*��6
  �X� F ��)%0�����%����p�}�%��k���E�|����{i.��L` `��V����\�� 6p@j@�k��`�S�PL�Z�Q�֔b�A5���k��|��w�: �E0Wbr &�`�R��cz��������m�;.��c?�AJ�3����xRM ������?j���X_�W!� "*�$�q�F���|8\�$�o�����ۿe/���b�|�a��Ϻ�,L�l�8�e��n�} ,�=�ԇ�nI��!N�4hN��ʩ^wE__~'�_���n��^$���g	f`b�����+*���~�o7��ֿ��߯~�).K��e�b �K��Gu�P���+ �_C�"�Υ, F �0�hNY4���v\�%��O��b��S�o��}�%�����b_��q��Ca�'�.�ܜ�A:�a�-�õ}�5�'��:��8����dL���r1m�[aϒa�0����L�2
J�H�+���u���ڷ��b�
܆
P�W�vO�@�	�@��i�����`g��@FE �M�T���Ft��nǞ�������}�Kݏ�����Mlb  �� � ��8{�0��Aʀ�  �`��َ]��YQfe�-P5N� ���&F�=Z��]ＪE ap� �e�ـ�L0`�#�]<���ݯ}���I1��0�M��K�W�	� @ǿ>$�r��t�p �oYQtpF�	V!BG"�CfJ��`#zE�a�ݗ�/���s��/?��<QC
" ��0�a}�I`�JO&�&���c��'/?َU+�  @b6��f�����G7[Km1ܱ�`܄�0�E& �\�ӻ���o�z�����?,��_��-?21d�Vy����V ����K��Հ'�a#u}!�PT2I��T����1\��ϧ�7����������;W@&�� -A2 e## g 	 @@ ��xsx�h�~�Q=4�Z�@�8!'���{o�՟��_���֭(0��`��A��P���؟���?��o�b��<��	 ��$�f^�"Xf�1�X5�}����S�()�H��TL���+\aÞ'�+����%��Q_?��BA�+������6U�,��Y"�8h�&�  Y���tv�l�_tCQ&P��T��G,^q��w�z��ݯ����iI� (�� P4H ��i{1��ˏ���i�	tKK�VVo�f !��g�q�o��*�_1�f�e��n���D""*�5ӝ�6�D����/��[��7����0�P� ��6��l��\��"��D��  ��@�6]-g������U=AB1&�1��y�+^���w_����滭�R4	@� &F@b {�a����9�xSM� �D  1j/��5 � @�P1����� jfŚ�g�0�H 1A0�M���;��%������S~�NװC( �0�����1�W&����6�ad�=vzv�����u���C��^\^�{�8�l���[?��v�=�Χ�UH�pQ�,X 
  ��<�l��xH�~):I���EM��h"P�M�t�B  ���_kW���CG R���9���牿��{��G��M�52�u����	�w~�[<O���kp� �7Lƺ�~�<��~���,�	��
���&/}��_|}���l���ˡBa	j����kX�o�I0��B�%B (s �@$�l�@��D�{��%j �@�	F ���e��	��tR�P�W{�	����sړ��o��<,���_?��P(�1�ЫM �$ � �!?��O�-�D��O��]2$�aծ��e���ʍZ�(����R�|�=�����w��ЩP
DX  Ka)�B 
��  ��	H�@��8�rS{�5{��( ��k�[��P]����)�J]D$�J�pX���t׼��s9ԗ����p;�0aҨ( ��L�w �S>>��O������$+���J&����i��%������NtЀ�� ѫڝ�_|���t��p>�e��ᢞ	 D(�� A�-6�ԡ
 �vn��'gK�0���M�P
  ���k[�lk��,&&s�c2�y�v��	 ���`��lfl��w��gg�\>ݳ
���\�3�|�G�5����������E�F����͛�R� I�����n���G�-�8�P "h�I����G��������6���#A 
��64�EY�A(��������&1  H�S��k��l"C������݊X���|��/3�&Yw��Ò� E"P��YgT�@r�;Ϲw���	��=0Q�D�BL� \	`8����������������Mo+߾x���ݗh<��R����X.������Y�6Bj��j�#@�J�F���׺�/f/�˩DA	H= f  �(,p�v������L dS��ӫ��n1�� �h @
�AG�[�B|B~% pP   g���'���aٙ�	�s���tM�%�8�` 3W�a&����7޿��vqy��)��Qw�����'��T��R�
�e��M[\]Vu�E�(r�G4�Ҷ&��ã�����r���R� �����A�8W0�*�� P�m#@��G��������4�!  0��j7�� ������a<կ�HB�"�2&K(���C>���}��m�V��#}K3��#n�F��~���?۟n��w-����ڈ&����6�[�%a�ɴ:e-6��yu��O�$�EsԼ�-�M���?w�>��<�բLB@� ��(��=A�����%6! �@��*�ʞǛ��d�&��
� ��Ev�H��z�½����Ym��e���,�i�H0�+��sp�|��}n]7�;6��P������`��݊o_�����s��m؊��ma_�"�8��͆�P]��#�	@5� �0ӝ/>���ë�����F�,�2 ��L � &�0�,"�j0EF�B�K���r �:���0�=�w?w^��r��D�@B���/�������0�1������a�K�����̉����������#����p�;����`�+�?Ə�=}$�[��'�.폁˥�jլ)�rɽ�kZwl���(�Z49���� *�Ƚ�y'�s���`UR�J�2R �²	j�2a.�a��-#\����	 ����������p^���B� ���צ�� ?df  @��եBMͰ,H]�W����e�(n]H�؁��5LԈH�9:�,��θ�2}#}�Ϳ~��˹�?��+��
e4e�r;d�:�R��o2���Z����O�����E۩(�!$`
(� P �"������P�B"n1���.F;����f�O#�k @0b�&R���L� �&��L��V�[q9��BB�`,CX2}�ꘁdͰgSO|��`�J�EG8Ќf(L�G��s�������������LE�(��sE�5�P jbN�D(�籈���/��ާ回�Ѩ$1 0X # �I@!  Y-np���i: " �m�Ĉ�j��������- E�2������ �0C+i%��la[s��ϧ0-Kpe�����%#gP����w��v�Y/6a�6 ��!v��76�/c�� ��(�TB S�X��NA�����;��ӛa[��(��g)1�)
  �lgK���=-�di͆��!L6�A�ǭ�K��1{8 �tA��rS��q%k���sXq����S��aV*��k�[�\%gjgh�=x��n68X5����'s�ûŜZ���B�z�����h[ٛ-O�=�����߫a7$�d6�B  S��\�O 8r��Z��:�qurYP	�:�sE e H���:���d ��� �ض�nm�ӷ2�ӧ   �v�/q>�d.�l;Cl&e�dd�9q��k��$;��Pt�� >��ҷ�D���3 D�9�+�W�(6e6(��{v�+��f����
�è `aYD.�� � a�l� e���3Zz��s����Zj��	�N��	�e����q����ؽ��P���D� lZ�ٹ_��b@�r�q~h;'��9@n�l��LI!����bf����W�`ce�MB�k  �8�|���������?D� Hؐ���A�!¦�ރ�޻v�~__����j(��,�)   ��&�]��elt2vgk:���V�Ғ @�	(3 �=11!W��^E�ӟ��.�J MJS@��ݸ�c�� �!���	L0����f���v����:K�;:*3q�}n^��%nۇv8@܆�"�ӷ��! zB@���������P���k�c7ݧ����\0�l"` n� )2���Q+6�P�^�H�� ���V61�z��>|�^��ݴF @� y��<�Kq����+h�3T%�N�%��;�̠�@DDffNL%7��}�x���������bc�I� "u� ���x�mH=i�=}��k���k�0��
 ��X��E  �#��ƺ]㺍��{Ǘ��;�CP�� ȶ/�6b�l@�
�w�q���W?��p[U@��D�#�L�X�^l7���D�1  ~�<�   �Ӊ���~'ew>deQ
@)d&C��s�W�GV�O�i>R��b������.:"��1W4<Ҙ��޹������/7W6�R �I�� 	b"� �@�`-m�gmWf�;��tm�7��EΕB@0ľF ��2e�D��^���_������,�h��4L h4�����"v�� ~���������^�}m� ��&K82U����O�6l��@��B��1�D����T$ @�7��+e��T�{��.�^�{>���%I�ȀE �E �B �=cG�����xN[:E+��
%GA�2x�N��f"h Hɽ�������{[�ѩ�eA� M4)�m��� �Ey_<k΢�
u��o���v^��Rw(�Aa�r����O�ϥ+�6��{�����0�~'M�$L ؀Ɛ��7�;�g7�����փ���I ,�!� a�쑁�R�h�K���2ʱ;�d���F���%�2
@ ��s�D�h��~rHe�>:��3�h:��^VG�u�h��D0�H�z��  ��kPO7������[���<� � @�dar��ݗ\��-� 4�
  Wi�}~���?��!�KPΦc���0���}z���%&�jH#FQF� ���I�)���n���y�t<ݽ,�[�~��D��^C!�I�f"�L4  b����ho��?��w��n���:l6�9m/h�f�$vr�?��Fj��A'   �ͱ�����uUuDD���DR��&������hC[$�6��`̱�q4��
�r�b��?���>{�Ͱ���"C�@H�"F�����t���t2M�V�m*��ROU9��!�h��7�G�BLe�߼������/�ӽ��ƚN�Z%ey�$O�D��׿�F�zDn�3  �a7z��}�}6�~]�� �H(��I��z��;�(�$ " �cz�#�l�"� �4��ƣ���N�����E	 0K@� ��  `Y�X�fQ�T%�㘚�J�<��P��ىpb���#�WrՈ���d���Gv���ɶ�PV�T3�'EQ�vں��8�Gc�7�g83��崜���������֔� @��P�2�6�=�?�;�Io��L*6W2�� E�㈓����� (���hm��Z�f�q�i4%  @  � !�P ��b��v;-6�v*W������j�K1 l@k&D�#h�ܹ�W>��b�i��b>ڝ��-��?�}�ғ}'������S���!����Kҭnepn��'Ǿ�կ5;m,�220rd�湙��=?�n.��ߍ��c 	�`���|'�~i�B҇��]�ϋ7�n�U*I@
�� af�;G��t���/�s�u�k�*�CD#L4����h&�����F�!I�6�b��zm������ܟ�/?�8�i����1 l�{�Sq�A�R�� �)��i `Y�58��!>^�?�\  BY��9K�vn\���w��τ\I�&@ �Bј����LCHlBOw��d�6�k����R�D X@��a�����`�:e<��p���Ē�abqǉ�hNA��,�DpL�b�,���iN��ߟ^��{�߿͍�d{s�a  �ȠlH;;�n�(��ɷ�s�.˲  �#z���DBF&@<O���)g��{�[		��.4��
��& ��D���t�zz�]�a������h	�0��u�.3�uT�mlPG*���C{ʇ���b�m��_'��9����9�!&�4Ǡ�O���>6�a�_��ݼ���?���O�   � �����n�����wis�e ���9_�~��U�'R@�����i�_K�x}Kpsu��e 
�  ���{��u�7�^njMU	  0e���	$I����].�6K9=��x��V�UoK]P���4����//.OO�>�@���8h��dK�[���������?t��z��7���l���q�?��K���\��m����_��?�.��'�~I����O~n�}\h��1F )f������yJO) ~(��p�
 7$����4^ �JT4h�hBG�����i�>�����b�8S$�es�	ql�	F ����ʤlDޮ:]��[�CF�B ,@�B@.�lr$�`�iul���ŋ��b�r-�N�Z̢hB��iNc��6�������L5�TC��7~��+�����t�]���$���?�Ž}8r�~��G���=%d�L��i����� D�]p�t����������8Q  ����}4dR�)4`TJ+�Ewxx�����$�k&� �9J�������e�r�3Kww�������k�l4H �@
�"l�I���&�e�4D��x7�����E�Ac!ܙ1���b{Lr�"g��_�Ͼ��_��[FF{��G����|W�~(/ߕ�����r?��᛹6���*��YMjm�b��M�/c�����;�  p���'�6�P�ҩ�,�l�����|��#��h�@� t�_�e�����{����֋Mb��Q�, F� �,"�k��Ͳ<],>Z|�r�^���QLi>�(��;L�fSƒ���g��9��}�	8шٯ�i��Z������,�7�?����M��Q��C����Mx�p���=O�pxʻ;-� �9� t�Rd?���#��szy �z7�����4�=P�j��\��%o:�-x��$��S�N�%�(1�@��1�a���V��%��3}��Rof��2,�,�"�h��������7�M����.��bÀ�r��XL�	(3�X�>�DbȦ=�8�aǎa �  Fa1�����K�D11b  � �%ǧ�����֜�|~�h��^x����S�84�`T�h 

��&ܿ���%<J�@�a� a�c �s��#��f��U�����H)�Ab@ V�vY-��_�}�p:�)N*Q��G����3a#L�2A `#�0QC ���x��*���#	 3��d������8�V���E  k�Qw�s�X�@�
��l�sn\d��<93S% ���t=���9�6�L�l�z=�yy�)�h�Fb������ rk�.6�U����ev��u�bІ	� ��z&e�� �����D��<ɥ��l�)�b���c�Z�Ȝ������-�  �d8� ��z�}�xG�-�
�QP4  ��a���͝���<Yg�D0��a@`����cJ�M�#w���=/��<\��a2d��,�2\�#�n7�S��������m|U\K<ӆIΕj61  L�0�W�C$� �c  ��b�L��FD�
`� 0&f�"P���O��m�?�5 �$1HJ�Ha�����셑�P� HE�rFZr�x�]�&��L [�1*���1d-oz��k�9�hL�P֪Q*�@
	@�k�úU�ɳ����t[��Ql(�!
 r6hP�fR��V���9۹�`�`?eF���t�KW@�븎	�� ,Φ��{SW�S+)�.D  4#��3�9?�E� 0G�����͝}v'���|-'_�ujt�e����C�L�gs?�Gaod8H�Pb   A���D�t�JyY�+�����,"6�c@��H B��?;��� �)C�8�e�qRJZ�tyJG�+00 �M��̦GSw�M��  2\���9^  "@uq<u�^ܛ=� X)�������������_F��և%@,� � =���}�x��� ]h���Y�  a��>-fώ?iƶ��gqv
��6 l����,{ ��f�S�  M3>Aq�P�B@ 
 c`Ĉ1(�%Iz J{���!�DlJ_Tk��@����Y�'VRQ���`(�Y�ɜ�q��ۤߞ��<}�z	+@���c똣���ƹy���y<�O� ����!(,�[�,���7�Ŷ�ߔ��S�邉A�ߊ�&&f" � �	(#��@"l@��:@�Fi��qZ��	:��DF@i�b���4v���
 �ā+�4\�1  �˽�̞k**@�qb�B	�*����t��\�O�M����Y�����`�Rpv��&�r�T��d�d�
�h[��Z�T\�.Zt���9m��\z�ѐ�#�� �+��W������lmI�䠔b�10&  �2���@�h۝��ktj� ���7��	  ]@�����{�{�C

F (�����Ν=�o��ӧg|z�����dk��-�,��Cg�|@ �.
���Ům[ݬ�;�gi���t�#&v�j�Ā��P���E`#�M �@�@ ��͆rddj�����돈�#â��P��P7[" ��L^pq�J�V�nP��[�Y�*tTj( �(T�)9��+��~p�>��-���/sa��-|�0i���, �	 ���m���6F�F�|X_�W)�K�2^�׸c򈢚j��Pf"\4 ��� \���cpb�H��g�#Wo�U�d2�7� �ZD���P7̛�( �� �Ƞ{���>�ڭG@��(d
�@ SBS�s6n���f<>?��������&� � P�h��i{��{kZ�)OE�ZliҘ�Q�G���Ҝj@as6��$B�@/ �^�2�����O\��)���`r�P$]�4���5Sn"Xk�K���I�a��x��xeȼРC���@����Nm�%'�l�[.�)�ft�%�儍Cr8&�� �  @���4�YPbW�6���X���j��6?�i�B���i��`ʀ  ��l  �i�K���t7v�ĝ,�� ��$# 	��bĊ���11|s��p  @�Yz�{�r�!�%:@� F� �rf�l���f�wnܨ��o��c2���^� 
  9v��M��v�綾�k�_J��)6�1!$��+]Ǝ�^>bN�1�h6@b��'͕�@��09@ �����^�����I� _P  H�f*�F,���4���.e�P���y��q��+��"   ��2%��s����_���XL��5��   �J��=�.G6�����W��F����r�QTC��I�ж���K����%]�G&�\�G�� ��l����lb{�����o�z��<�y031�G��2uYź>nU�T�DLC��Q �����x���I��ì�b�����(Bu�7���I/�.�n8�>�@(@(�ܨ'(��4���cJ��J�(���a�cO�毿�/L���	���ؗ6e{�I���wt;{���#c��))�@ c�r�d�&�*�*>
>�Td-��/U����ߚ��ZϋݔC��$�;Us�J�-�,��^)�p�Z�b�B���N� )�M?(.�۽�W�Ŝ.C��mꙀ�/O����'gr�9�i�/�1@ Г2,Ѩ�[�Y������lۿ��G䅧� ""	@i�5 ��
՟uɬ��Z�7ʥ�EQ��������ɖ�L	   ����֤�q��N$��LV��,o�;t� �b��~�}V�b��y���S� 6b��P\^�{������i�/iP  � �@� 
4kO�~븇}�o����������,.��YA��L�cI`�(`�ɘ��HE �V O�n���Bg�r7{�1�@�7������F� 	�����J�SlT����gr��'�KK�b�1 ��#ш��#m��/���k��#&=Oc��	 �`�l��E�����	���߰?�џ&m�3{8�@D�@E� �xz����UA�  �1> �8�J���6�Fk���) ��'Z�<�Jvgte��I+D� ��ީ&�։�q�ةoCS�%mc���y��L�L����ƺ_����EOcRͦ�F @ 1@�U�8-�x9�紺�_��_����{<=�{����x$t�D s�1�IM�(��˾�	�֬��^���}ߵ��F���*(c�XƖ��xP>8��j�C{��h��R=�6�w���gl~E(���ߓn����i/rq%�J�Đ�3�6D�F �������������OO/c#7؈C�
��n�W�K��}��������}��_�t4*�@	"� # ��0�@^�A�?�I�E ���W��T
dI=}�����-mēN3�TH���ܙ�^%$!J=)6jI��­�f�q��4iwR3��,�zn7kyͬ�\!G3@s%F �y�ŧ�|�����#]�������p���No���'������y7�~z��hV
����	cAݠbG%�u6U*/����ԫ�rSF�@�����^2��m�ߘK�Rsc�Wfw�X�A$*Ճr&т?-8� l�~!�$�Z�ze-=��u��V�:��	`pdl b@/���(=)ߏEϋ}��x��w�4�Hd�[��w��e���j:�l{�7�� ��H`"2R�Q�5��&��RJ�9���ji �B��������G.|o͆��]tr�8��Zp�I�Sl�z��z�`�]�&u8J=��D����nv�(Uf�}�j3l�deF.�a �F�iW\~����������i��o;�Nz��'�x��ʗ���S�O�]gQ�����=�7?
 D �""���+�H�=�]cT�3Δ�:�l+�j�T��Ο��{�ɓ�ۿ�Ϯf�?j�^��ɀIy#P>�N��O�K�n�+�	LH̱ H�Ң��
�0�-�'�;��M����Ͷ�Ғ]�6�n���*w�ȳ���U��W���wo�$��n�k'6�����j��O���g�	;{�ҳ���� f�(�� t����"���2�_sv2꒒%@k��*7��U�@y��%�������o~f���5]m/B8��I}�mh!y��USߦ~��؂xq�e��Lf-5h�k)M�;J�7�v�lRM�T(��%J�L�,ˌ^6�ڡ�ծ=_���;�����r����p�0�Y��fäV)�H�� F�(Y͎r�wG�v� +��ix� y�Fyڟ�}�{�����ӝ�e*�B�0�şD�(yCq�xM}�( ���� c9�R�N���r*�
�ޢ[�?��7[ƭ�}�x�,�.Zj�n���Z���y������c���X̝lݟ��lVF.��� ,@ 9  � ���@��*�l���� �J�E��}
(o
o�Ee���;�G�MWY�������g���|��h�O<�C,%�'�  �����%]�E��F )�*�Be#W�rI�'FG�5�v[�Q�F���x�޾�Q��7Ƹ��< 4(]+�\��ї��ے�Se@*-:�2>�D{ ��� �f£��v�vF���yE����Jx��w�+������;L,r�������� h�Cב2g	Kh�~�-�	����M0E(�#Kr�!4�N<4JT����B�C$��Q1�H� :�Y`�lTv�f�d���W;��    Jx���#�T�,��ۯ�9�3�{��`W�#J�x�>q�<wENn�ю�
كDv%kCQu��ak5S�
(Bc�&����L!  H� �0Z ��(�(\���(\P�h�!(A'(!�b 	BSr�f�9\�&A	:�#h ������d�/�q�rW����^��bT�R�B�����gn�ӊŃ�ȃ��=w������#��5ʥ(9.(7��5l�b+%�\RDl�( �h0�  �Q�� �⌇#rL'HbKn��cBTB	  4�"PE�U�
�-ݻ��e/qT ���*���G@������K�1y��ɵ�[QO���X�~���9?xG�����Sw�##D�U��Ʊ��_"it����F��B4 t
� H9�lM��h @ ��tl�8	P�s�2�3�:�NTLb�lถqlѽ;O��췴��P�M-��'/�TN�*��������ҍ��Ͻ�B��E�[I>��ٍ��M� B;��X��z��\7���t��T�f��e�F�&ڡ#�]&�  �>i��F >$�c��iZ�`b�D�5�ɭ��j���V��}뱝��@f �W_��(�ؕaq�'N�=}g9P����|�k�g.Q7�k��]S���q�A9�9 B?g%�t�J����c�T'�DUH���B��!��^N�L�M@}�@ �  ���1BH�¸L"O���I�����ˮ��bw�d� H�z�3x���3�Py��
�s�^���G�������-��������v��iso��(Q� 9JA B	�58�[؉Aj�l����ݜPG�xH� �4�F@�yi
 E�!�  &�F���4���N��4[YRj���#@C�T�Wˏ~N�P�-8|k�'��{���W�S���mm����Q�X��B
`�ȡ�@�  �@�86�����N��g��7j��-5�g��*�P;��̒h�/���hB  `4�*���t.��.����yKkߛ �#k  ��4$;��h�����y����Ӄg�yz�g.��_Є!�{U!� �A !v��
\�gUc �Y�f�FCzA�ure�HQ*�Y��H����H��v���A���V��Yd7Ҵ6�ma`B�P�bbT ���W��ˣ3��+�������}�����cz�	Y^���� ��([�!��f� ����
����|C��O�{ܫ��1g��!�		- *@
��(���L�B  T��̠�)Q)���J4;��񔓶v  �J{U�  �" :����p��_��}͍���c�?������1��Cz��� ����I�2L� ��\�[�в��`��&�m6��H�q��hM�	��  �HQ(
 ��}(��֜V���s&���R,�G]m�d���4�,� @,�)� 5  �+P������4��;+��L�kN���M����ρ"�  D���b�.�Hنk�_�짻ٷ�62����jO�:�!I-[-kC&eBY���&SY�A�$J��)2�Jt�P���v�����ۮK��*���[D_�kD���&Km�:d l�&�2����d |�� �	3�[_v!�_Ww�� ��P���P�QN�� Խ�N  @� �Ql�E�w�y�����['N���m���&5L5I�Q�W�*��)���Em�K}�]�����O��Ӯv��ʺ��"�T	  F�P  �R}|�P���B��e�����P�X	
�� �â�"x�@ܷ[p�+$���o�RHl+��B�5�:Ȉ� �Q#W��@(+)Y�T}�:�a�P��(�  4Q�y��   � 2(.[_����l �"�A9r>#��q
��l��N �g ��� � � D�o�� �fE����� ���� ��_��"&  �Q_H " l� 6���
ƫ��,Jm��_�k /� ���U�p�_�cp ���q��pN:�RxL��� ����� [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://n1f477lg55gn"
path="res://.godot/imported/index.apple-touch-icon.png-8085a11cc297d91deb55511843765958.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://index.apple-touch-icon.png"
dest_files=["res://.godot/imported/index.apple-touch-icon.png-8085a11cc297d91deb55511843765958.ctex"]

[params]

compress/mode=0
compress/high_quality=false
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
GST2   �   �      ����               � �        �K  RIFF�K  WEBPVP8L�K  /�ͨmۆ9e�#�_G-�� ��&��mc�n��ځ���� 
��$EVD�y��m��H��^��L�Z�=�1w������m۶m۶�������̬�=mTu��|�ǦR��.ٶU;�4�>���=�2 ������Y]���U�����%��޻p��$I�l[�$!�sߗ/���j���h�忻�  ij{m۶m[g�e۶m���vm��m#In'Nz̞�?�߶�x$m��W���m�gn۶m۶}߿ٶmcl��T\U�y�KΜ5��ڏ�m�#۶u=����PDB������YX��R���0��+��<�A����$IRm۶-��c,���o3�s�4:�m������:��m۶�ٶm#�m��l�6��mI����~�m�1I��i���
�3Ƕm۶m�6�Χ۶m��e�*U�H���ؗ��*_�m��d[[�cε�$�L�t���0'i���f339���9�`�9G�%I�j۶m���Z_��V�H�a@o�B��6ʪ�1�D ��z8.  �ݚʌ�ߪ \`��Ȥ '�$� �D"�L�fZ )sə5�9    ���U  ˧�����  ?�8A�^Wɿ��=�E ��j` �%�䌯p����`���B��~��}ty�?��'`P]����U�M� hW8 �yS�/����gk�����r�o0�T^��M���}�`�Z�֠�� &QsB(Ie����E�x6�i�.p�h;\6��vj��� OfJ>�w  ��r��=jk�C���H����0�   w��H -�0 �?�\������I,��jI	�$b0c�d�����?k?�� �76s�   \4�n ��w� ��Xa�?��Yy��4��Im͉�����D  �hp: ��?��A�N�������+�B�����`0�1� 0 źձ���G�ݻD;w�\����J��\1�d�E6,鏃�,=y���ok��h�LO��jkjkR�;>���/��  ֧� L���<���5���y�<��H@� ��<���1��&&)�ɢ�����q�~�V}_�ԧ�O�����**-	&'���&��mp�Noߩ�����������?�$��?�D�����Q�)S� ڀ>��\�q���yŞ��\i��X��8"��J���X�b	 �bF��*%����פ�>�^W" l� �%�z�֛���3k3�ג։"i�f\o���ZR�����em@�5� ���~�bOi�)�}z�q�HX`��8F�i���Č Ƣ�&00v,xl,L��`D�y*i0Fژ̾��Qb���a��Ϳ @�����?�y����P�[$e��/K��@	U/PB��������< `Ly,  ����ϫwK�?˗5���]F�@ 0  ���:�"� �����`b� ��5I1���dp:s_�P`$��I,��{t 9 H ���f�ƙ��u�Aԃk��S��?�� 5����"����  �( ����x�A_wy�������/ή����˸�z��f�a4�k� �ib�<kV �	`�����`���")L��A����H$����xH��e]��I���'�֎�n�?Q/ݓ��^�쥙3�� 5D�P�
Y���m���
����ͷ���r{ܰ|ܱy����Ot���ʩ3S�c2&k&�`ȓ�!� `d���رH:̘1�H�I��03.r1��oc�'�ħu��=8�uG�˃���C{l��n�N�-h�
9dR���� @?��w��ix�G������%�7�G/皆9|����"9Wʫ�L5�h3��ir1,&ĸgT���x�#��"hSptD���lD�>�"kL[)L�I�X�J����yS7����V��2�`C���'�LuN+���n�St��+�C���n  |�%��74^}��i602"�zڕ\��s���n�9��j�s5��1;��{�k��H�f��\jx)�b��]���=b^�ALh22�X��4��쨳��&��LóBu4k`�H	v���9o�f<��=��+DX�Y��&	�Hv�n+�mІJ� I�_T��P���[�����d@`0L-�z�3�����[��B���v��y����=m��b��A�BȄ�O�&��f� cG����V�M��g��M�sx��U�i�%�J�tEMLĜ[��ǩ_��jV&ZIH���..�ѻ�]?9's�N��w1HAj���/*  ����W����I@+������u"���7��d����ۏ�%R+�鑯P��O�k�  ���cE9&�i\���C�;ޙ�a�;ˉSn:>����X�&��s���,��d�D�,=���"+�75Wl�.)�RP��_V���h��[>9����=����1 �q c%3��,��;Vs����7�7W�/��yx�x����2�<�+�PQ�3T�Y�>O=1�|�ގwξ���]��̺x�٬� !�W���]��K:E	��7����iv��A����
�ߟo�߿��poXj������.�X�����&�s~��o��}8ᘰO��W?�w_�?��ݑ@W޲��   ��!��*T\Ì焙����{�#��J��f�+8p !ә�ۥ70���..x����O�5x}w��
 �!d�|^d���_���ʮY4Ɗ���$0Ig(f߅c�=�������.ه���PF���O���M������U�xp�-��b*�
S�Q���Q������q���,'k�.��@��k��du�4⡊(f�=�9���;�0j?`  ���Z>���E�
`��t
���UZ;<$&)��Iiv,_v,�V򓅟�'�p��du(�@���AR��]��*_����;����-ߤ�`���<$������}�/�β4�4�1�)H�X �3��H�KV�*� H�b����K��翻<p���X�G>�	P���V��u~ϥ5 ��N,�r�ͱ�ң��M�k�>�p�!���Hc����('�Gq�R������ߴ��Gjq9��-�0�J��^s����c��X5+3cL 	z#�;$3�3�'�\ �Q ����������1������f�udu ��/oe�;T&�`�`���!x&6��9����n�a�D9g0$�`��HyԯS��?u���;�8�v��7�� `RK��n=��k�b�4QX �� �&�<�+R���*�H��   
Dn�{��ǻ��`��I�ud��*��{T#����+�~"jH� ������b�w����%�M(Q�#�8�Q�D+L���G�ڟ����_�$��e��'� 0%&�y������ޚy�
� @  @ ��s$ho��c�y:=3��� �2�l<���Q��l��W���=�iN��K����ٶ`-�`*��:B�����hy��h?!�%�X�<$vH0� �`H��%[�}���/����D_a�
��m{��ۏ[���դS���A
,0It'fw(*���x<�>��f��u�,( �HX�h���\��ۂ�,�o� @�/.����9:�� 0 @�;fK������	��5�.�1a�c4�3T���X0 ��` ��G��{����A����۩��I#1>r�ǽ�>�Ӭ�,�tM*%���IX��=0��n�nX8Zԍ�P�z}�}�z��l�+W!"#�s��nc�ธ{Je�wܕ�w}��[
2iaŁA �z��k��z��ÿ�pdå���q�H
���#$�����`0�ژ��]��ҿ��N��5�N���������D{Ʀ.8p� ,Z#g�Q��`nר�ڡE�,޸��׺��)  d�B�,�kN�m�����P�k`�0�[T7��	��Y�c��G�: C}&�g�����ߜ����+'y>BY�P'�W"�~Z��F�B��� ��0׸�Ї�!��E�������wf�n#g״+6� �`���E1h$��Z�7f������D�~�uC�~m�������ӕ�(((P
��������0 [ �f�1ȭ�������t�0X8)2��̍�t���#����텧�P��|�9�|��B��r�5�l^��� @�T���r��?��?^����w�0ӨDJ�  �H��!Ʌ���b���Z0a�r���Q7$_y�ϼ���ᇳ�OY
�B �h�3o�����'z� �  �����G7��,.��ر�1X�,�s+��͡���;����>������;yN6��9a�J����cE7�tu�l�����&��G�x8�o/|��X�S0���" ƀ ��6F�LjX��@-�6//BC�/�C`�}��ʻ����1s�8kJT�P�4)�t�.��
��S#�{}a�6�������b&�1X5�y,\����-_�/�O����o���T��O��f�c�C�V�$J��y3q
+�AT�N��L�=����?^�_^����#FB�@B"@��dBB 4g�+��4C-Z�kh�ꇂ��A��µ||}�]>����p�8yJ�(cb  #3����!��I�j�BӴcǀ1d�C��������g��K��f���{���k�e��0C��	~�q� �@z�ټ|�l� ���������-�\�_n��"c�Lt1�1����Ġ��,͙�G����,$hQ?nB���\��f L���B��Ͼ��W��a���VI* ##�3�(cQoo�м�@�B�q>1��  ��ur��}#ސHy5 ]�}����ݾO��Ǟ�Ͷg�j���]�t��My�:��		�L�ú�$	Ĵ/ы#W%����0o|常���6m��-Ñ I�')Q$�D$aH�fu��1�XX��!�E��=��.^ay��A�� ���.�����������pV�e�� ���e�ۻ3�w  e  ؛�N�����Xb�X�$̬^��㝯�;��(�)���c�5�g�[�7w63��	���Xkm}g�lb�H���b�1 �U��l/z���ݶO��p�1�Xf�e)C���91A���7�ve��$E.K\k^��>m����e
�@6�sw��x_��o#�F �   D/g�	lF �+?Y�O��Yg�YhWk_,�MRqK&����_>���|��?��"�qF*�ij1;o���c���Okc}�Ĭ�VojM�*�$�`�~�u��<8�����.���	���2$eb��Y[�s�cv]��Q:r�H�%�ҏ#!�@u��g�_��N-^
 �  Q%mǽ`�lx5�f1<�n�S&uY ��%.���;��@�K_c��j�B�o�+������{��>��O�����֦J��r�L:R�=^z��=�}�;��6�βjG�"��
�#$P�l�2�j�ڵX�@"�: $/��\�2  ����6��"�����.�~�`�4k6��>� ?j>_��u����W�ת���w�6��*�b��A�U�k�7�6��.�d��8��2��T}�\��I7��'���9�{�c�M;;;����y�O����{��b����,]�!bΚa�Y��Z�9�{̮�u:$�r�"���s]�;�I (D(��Z���野������6   h+�b�
�}r�U���C�z�ΐ��\iNslwU�3Q��q�����Π�!�ήrL-���e�rG���]���I.�vq|�o�����k0h}��'_�~�?wyj�ҁ�:�$ɐk��,5r3����Z�Q�.�t4��\FP#�بK���`��F��%tQ��;�S����ɜ"X� 	Vu�ӈO�V��� �+�e�}�kǀ�Ng�I�ٝ���>��ާ��K^8��O��������ɿ�E��/r�}����l��n��ws����z3��̿=�G����3vu���]X�o���~~_��s���ɖ�v
� �A@k@� X2A�����=vׅ��$"�)rL��H�1#��x������x�Q���Ε& F��4���H��^]f�o[�	y�	����t�x`ǡ���6M�k�yt��ěo=�я~�y䑽�)�z�"��u�����{��w��;�p8��4�3w���n1���y`��\��3��3��ڴRa����!F��`� ��ij��V��u�Б�o�3��̜�G.]}���3K�f``��47��������B�c ���t"TYW���M? 7�+%�޽���nQ��f�N����<��8�p�F�K�|�a����7b�j� ��ct��ә���{�p����S�e���{wX���ǧ&�����I�W��A"�E"$Z�k�1\�E�r��+��E.��=:��yT�~�z�W/\�  �����s���ǁi^� (`:q��fAy�. +?D �7�G+UfZ@es�������b'L���b�un�g������g׍w^������cC wi�4T��%��f�&�5Z��0q���/ή��v�N�b�B3BlF�a��BGLK���q[��ՙdܦ���I.�!1+W�.�d�@�"���X����C�������X���c$�h�u����n���ã>���8rz��.;f<d5;VG���s�6ՉNq�bn·�9���th�Y���-�-SY�챩��zk�~|�ɷ�[+}m�R�� FUۿ�@�a���� �٢���s|�:��H#6S㌁&���Ӌ  �m5�6g���e��s�DX����ɴ�&�~�m7�[��g���l�����]&��t���p�o���|l��"�a�A��p���L͛�os��{�=�v�ӳ�}6C26#b�#�2 �@�K�%<a�$�S���c�z�=��0��0\ݹ������#AB7��#o���f)�`z�]��ufuD��y�<� ��׋>#�� \71̭gױb	L`̺α��h�-���Em [t}x���L.���7ծW�6gJ3I"���ޗ���(�y�*O�9�8�-[[sL�aΩ5b ��~���1�I���A�%jx����|��=
E�>�~�``�]>=� ��� ���<ilJm[��S:!�S(�����k��a�Z�Fm���h_U*�Jom���  h @Dh)A4 r�J;�cO�t@�C�i��^I�U����˻�"�h*���{�/IW%�.�HP�������W�G�c�9�,i� ��U�J�s� ��v[�𾩉D��܎�h氀9�A���b���u���Y�a%LƄE0f(,� �=���'N6��^t:�P`�K���;�<��_�����t�ҿ���Я��Iy>�K����Ef@ L��7|�SYcbN7���2J6ռM��u  p��� p�ܯ?������&@��l�n��w��b��<�0@�`-����9]�:�����-�a�00`P�D0�����=z̕���x�Gco�]�����nG��9��e4������l��)�T�g��`l1E�s�b�*�9�3+�3���k��:��?[��L/O�qN˫ ��R;���>f0�6�z,!����)�7�j6���b �0,w`�g��g7廎$�F;���ڣ[x�s�~�/;���4���ϣ^�5�xl�������'�겴�"02L0�J�����K/x�4��\f�y���G�l  ߝ��W��@ ���$�_�`���SD'b`k�9�9��5HD�1�P�����8�]':���P�0�<{>���|⛯K��Y�{˵�ud�����S�x�ů�o������屢�D!`L�T����w>�t'Y�M�Qyl��M��`�+��]Puk@E9 0����u�����b���! @q{���V��GC'�D"L1d?����Bl!=����b���W&"P��1�t�;;�I��������%)i	�tT��I�^���^;q�����>t��0D

�:�~i��+o���_�GT�
K:]���֠�¯� ���l��
 P
C9��bi�f0B�z�	(V��Ҵ>    }���mg�;z��e��hO����E�Yf�!�<�a*��+��6l8x�����?�,n/�(� �T>�b|)Ԟ���k���l�J@�K^g����
 �����sy� D BQ
��1t	��f�!��5y��$	�$�`�3,�����p��w(6L�4��1�s>�*�������v36+�D��LHFH&�ѡ],�{��WYP�C�Q�z�;��}a5��Ǿy�ɫ5_f�  ���������  |`�#s�2������Ãbc�a-�_vR��/�c1�f�^  �&�` X,X���膳������m� H���}����[��M�hJrLY�af
b�B}�#;w"mD=�pF������xf���Fn��ԵGG�!�RB�q���[0?ej�{A(�`FC3�8ǆ0� ��E������g�;>9���� ��KJA�`` ������{�piP9(�������j�zp�e�ewB�5�8& �L ����	9��-���8<�wL͎/�M��?�-��bs��f�� X 		s{ � �L(�iF����:ֲ�M ��O������=۪t��LZ�$	I$�$H @)�/�{Gj���	����c�}���|�ۧ��:Z�r��o b ̂ �y$��x
��u��(�0��o��m��/<e�Z�P�: ��8i �  �&@ے�AE@� c��c��XÀơC�  
 (L����5������U����?��/���C��=�d��*F�3[�c�1mr��S�ӟ$5O����w�f+��ȵ�0<�Y�!��P浇y3%  tO>�a�ڳl��6��N"�v����l~� �  �:��$%w�#p�<3�� �L��Zni�6֓��Z D�O�����+\>�G�n�_�g�_���~�w_�QUr*I`" ��&�<����
�UY���y�/���P�y$�E0��f\Úk% ���2�?YBHH0& ��_:��pNXf��~S/���k�c8�T�� �+.+bJ((T����[gC#$@AAP�?}q��x�ï�����{�����q���ʷ_W�W]2)Ů�[h�gM�����ɯh��\��.k�ML�-?y��Y�9��ά	 D���(9MdM�V�-df�c H���z�d0;��Wy��~�g���z� �'*a`� ��6�j��6����O��Ќ>у�u������p�`���&>�{���tO��쯃�d�AM���Cl�5h���䃱_���Ln؋z�٩/�M�u���pa�
�f�Y�� ar0 ��X���R�{�}���������棟��^ @���dl*Op�D:��%��M��'�PHr�9�=:���H���x�f�~���^����M���/�H�Ǟ�E�$�A�H)�XY���~���Z���������W1���D�̀E��	 A&��Z�  @�H>�;/iF����#�>�A��  ������   ��k���F��C*
�o�˃!qY 2��������)��S�����C��Z���� $�k�D�Q�$%M"�`R����vG�����77�ݳ�f(c�d��5 x�5|�Md3�c�dƞ���#�<�oή��������#�0 A��XG		��&�(�����@|�4&&���~�-�{p�*~�?�>�{�K�����Q D�+ʴLB�aЏ�N�A�	 H���h�ݞ͡���L$�bd����$g����[jp}tЄ ����+0�_z���߸fc�G   �yбQy�)�L��g�"U�(## ��s��(L�����\v��ߌ�篖�}�~�G��~0[ghR�$ `  k �� ��F�ÿ�Nm�v��zm�u/V�P�B0�00+L\� ���p���C��G�}�������߄Ŭ��Y<?�ʗ�q�qR<� �C�a��TK|D��	(����׸2�g��6��_5n��y�{�?4$���J)!�I!i"��" p���0���ߺ;�=涃���u|۰� �4���  � L�!�������#��h�������O�?�'��� 	� x P��$�RI���$HČ!�(�}�1 P������_�/�����οi>��� $�b@�
I�M @d   �F5Ќ�:���g��]G��ߍ�m��������#�,r�ofٗ `�a�G�/�W������ޟ�Eּ5��8~  �  ���`� (�!S�II�R	�	�&C"�1���������A�����?����/6�B��$��m�* � d�P0A�44e���2�G��_��.+|T�6�e��_��o���������Є��VB��)]���pΕo0�'����!���W�ɋr*y �^S�X V*/Ŭ�LIbJ%Vf0�1�t��X=�4�<g3�ݿ�x�o����		�� {�A��n�``���L�q����ޑQ٧(]\��:_�����������6�Pj"! -9�d�4� ڟ\o�`�m��|���~Wy���D���')V y��P��DJ�R*�"C"f�$ŎM�ș�����'��7�n��k��g�ݯ4OeH,�bC�d�7�J�1�_v�C���+�a���S�)��-F;{��^��*� `���Y+  ���a�(���w���7��C���� @�"Oҁ�L�d4���A��	%	J"���7c�`B�$RЌ�W���x?�>XM���O����W�?�~ �^  H0�$,9H&H� �,�a [h���f{�CwZ��0`-MWS��}������	�'�4���(�M��C׿i���%ĥv L�c ���;9�D� x  0� ��$f I��`bǞ�0�L�^]�	Ä�o�?�/��������8���r0 ��` �!U};#������ � r)p��:�#W��"h���\�Z�{Y�����|�;Ocւ ���B��(a�o}��/E���Kظ�U�Z3�H�
���K��(uƧ��&�I����f-i�Fkƾ�7����:�<��1!/L嵒l������b�3%n�JotdkyD�@��)��O�q,n�ą�������6g� @K���A PF	�7_��ӿ����K �*����(-��" ����{� ��aJ5l��5&f$���0�����}����?�~�N�<y�c�,V����k��=i�i2�` c����t�f-m.��)������w�+�|}����N��+�c�L��%'�@ ����`����S��T������� �1��
P� ���"(U��)01ؗ=���8��_����Sg���v yĈ�L��7�YHyx����K&&�l �?�>�.�eoOT��@�؊��3{����������
  �J %3��
+sc�`�(������& c0 � ��*~��sN�s�$Q �+&x>9�G^��;�ųG��B�
�� bB^�G�j������ZXEu$ 3#:����[7�u#�+ڤM������;�4+2�a�` �I�d	������DH  ��n�y��������1 �sP7#�f �� _�   ��B;P.3��eϜ���C��u���B�C��` @�<�)�	R������V���~�ě�`���1k5ː ��7��֡���Ƭa�mZǅ;�/��y��g�wՆ1e� 3`  , X��� @�-�< Cr�aʕ�� �`�`۽��z}\��\I�M0I�ʹ��h�;�^yxģ�k�q����)�c��S�y�i�����?����~���OW�1�������@�=�n
������X�E.�����W~�����kY	P� p�  C0`�O �0���Q`��<��x�=�ׄ�� �������f��93��)s�7��H�RY�ȃ=���ç�i��<$�#�jR��8����W����Ʈ�^7��ջ�_��O���p���fw�t'9�2��9�RpTbĊ6�b��������w��<탳�[�0�e�) �Yj`� `��`L��=g����<V,��0�ܥ��``a�v%�>)x��N��m9;�F��G��0�y�Ҡ� f��oh��?��7E��ٻqP9�?��s�������m]9r���kZ�Miw]�ݽ׳�Ç���ٴv��F3��}��� K�R`C�b � J��%ΐܷ�m��WwĈ|�`�� V�tNU�e   �F���r�i�O\L�3�o?��9�T�`0C�2?{1���Ϭ|�/��Ƹ�m>mx��],��_W��v���Dc�i�6�����[�>�|�+�a�Ph���$! F�,$�!`�6��-����y��C��o�<�4y%�D���:���8�Wh��nh��Q�T��hyN�k�p%�yg�ǡ�>�S\�;$� �������WΏOC1�*�8c�6f^־���p�����e��J��`�~s������j��� ����0̀�,3#�r릓8�A$D�PF+v�ab�����N~�yT/+V��g����pD�L�L�̑92G�E4�V:&Գ���D�9e�^#�	*v0�~N��X�yl5.������"i��Xh�_.mo�s��˚j�h����ݯ����I��AҊI�%��	2A H�d�3���"���B �-��G��a�5�<��_��<L�Q�3�"�'0��uJ���}��Qn(L�1��b,.F�q<p��a<�	fHH��$�N���P�A(h����F�،q�L�̨4�����k�|����IՄ  R��t ��Af`����Iy����hX�P���b ��*�034����YVR<`�i��c1���#�
� � �   8s!��	=��M���s�c�jn?0����4�������Gy~�tF�"
L5�D�E��i���o{�=���·^�z����LX� @��2 ��, lˎt�έ쭺B�����iH�P �`�*ΐ��ω������X���<�>y�N	�V3P� ���a!��kf���2��<���;S_G�	I���xg,bZ,�9��j �a��xw<M뼌�	O�ٯ��^��`l�� X��"2 �ڙtk�Q�k�ܻ;��)R���4�)��i �`�)��O|�s�S]`� (VbMϢ�%5�K  �p  ��T�z�Rb�11YW�c��8��PI��0�A����˛�  �0�)6h\�)��IO����ko���z@� �drɄQA�CÀU��.�[�VU���N�aN�RMCӘVi��Q
y�g����<�k�y���.�h&2�+zV�eH�vr̽.>D *��+�*��[G�Y7m���!���(��7a�5�0C�� �sD�}=�lF��� `��eB�\�j������{O:�|�A2�`8�j���q�0l�;ڭ�|kco�ʅH%�T.#M��jLS��+���D����qI�����j֙@�a�ɨ��u�/  ���9�Ez��`$	/o�W��`0&0�Bs��ܹ�&���W��<�А����X�DR��x��׋��o�}�٬��L�'d0���� &D%�e�Z����KQ�M�"�Qt�lŤr` D�eB��m�x�Ǐm|h*�9��]Cd7�6Of���
v�(�߲�{Ð�`L,�9�D�����u`FuB�01!/���ጡX���G�H��˞������]�]��� ���B��S��.����4�.щ4��T��~N�i���AV߬��&M��=������/.�UQ�1��S((2��x�� �[����HÑ���{�c�&����bQ��q蜷o���u�< � �HW*��\�jS�{�{�v�h`  �YJ)�A&`��ݠJ����GG�!
V46jGC*�F�؋<i>��WI�A�2Y�ƚ�_};�/��e&�9V y��cMf�� �DR��* ��-�,�X���8��-���Q�k�pƎQ�~0����^��^���-gC-91a�6$�J8r����X�]�����~\y	>��Ac���9�h����`�` @�}���\ԡ�;ͰA�'E y����e��#yŤ���U�hO���+0������Ǽq�װ�c����І$>��6"0ۧF߫�_��W�hkV��}2 `X,���+��U��Nv�vm]��-���w�7~9��xf�oF�!��A!&l^�������.}������}q�֥/� � 02�;^�� ؑ|3�tr:9  >j��cac��|9.�q�8o�{x�Tn�!q��1ao̮���~���rZn"�%JQ�y"4���x'��w�M[w,�9:�4���67�|������TD5�ys��}�%��Ɇ�viSe�{h�M�~
�E�G����ɇ������ˏ.ZL0x�Ȕ�z����O �,�~)�hi�׬�1D8U�I>�n�OZ�*$j��Hf�k���~�~ڣg�YMa2 ���[��0�+�K��M6�K���$�@5Fq
���xZ��N�͆O>}�&RI$��ȓڍ�����#�q|xȍ��ֿ�����_n<�I�c���(x �� ����ي�  ?���3V,�X�4�{"��ԗ�u��&���А� � @�xz�k���s>�����D2` ҷ����_p����Ή���1�1�T��Zyzo�(TS$E�����5���3���ژ?�yĈ�L �  @âv����h�̓����0����*�����f�|��ǔ�`IW
 l�g��g_���,6��j?�Ɉ�`f�F�����Y����FG�D�!�1�u�rU� �HnC09 ԓf��`ꕯ��/n|��Ƌ�� �$�@0����(w�	�f��ٚ�ʔ ���� � @R>�K:���/aux����ɉ�ǹk�M�-?�����	��0 ����a�Rv�Ӌ��~e��]��:ESMcL46�목�A
 (�2Ƅ���ǯ���?��3]  ��rD0��hA���jʫ�޹%��@{�y$�V�A 2Bw�gb������W�×dq%�K1t�N�T带1]�O����|��9�^���`H"	�b�&��ʅ�ٙlsz�1��ΣiT��C��yYZ�&ĥf((�A b0 ��GL��)���(�:��j����$u$E��z@� ��St�N8�[�� �9k�(15���Ad�r���1�>����ϧ�"9_��Ǉ���  `g}|��f���Y��## ��$�FR?\���a@hQ7}G��Q3�\�!  `�V�n22����:�#�I
%
�X�����< �2m!�  ���uͅT�SЄ��pf=F2z4�|�r��x��8��ٓǇ������K�eHF��ؤ�0� �d�Y�@��R>]�=�Gݔ�C��  #��&�ob��;�2�:<�5VC��P�ԑ&H��e�Y/.; ���7�TswA[��7�PC��)����U�u���������g���)4�b\�'��W�'ǋf�Bŀ�`BE%26͙�+0z��EX98����G�h1/Z�߻4@�ʃ��8���#O�1���,�� (#�X�!���,@O�X�@W��	�r�i�1�T.2o����7.ə�����_�ĵև3|]���5��Þ���Ӧ5��`,0J4��g�3�GVf�.N�1���K��-F���G݄���;�wy0&�����|��_e�/�_ 	T5�I��Xe  �:   X�΃{��U���pm0>x�+��6��y��G�����ۑ�㝯��1N�� ��DI��\]q�6z|��l��iB\�ƕ�۰ ,��_����"P���b���<�r*��rn<�[�����m ���47m��Ţ��{�#W�	 f�Ͷv�@��k(���c��qdx�����oϼ�W/o���Ԝ�NP� J�K�\=#��,�4W0L�sW;���x��1��o�շl�fB�(�7�R:@9v0 ���/���׾���?\_T �J�$�͞�V�)���0��w�2첡����|xT\;��g�����������H;���
  �J�+G��еYޜ�!^Be�SV����O*�^�	����S�K0b0 `��<�1�u�!��W����|�`����
  6�����q��5 �oΡ�
���� d��fT�t�z���2;�K!� @4kf�h��^��+,�O:C4�zԍ�Q7ژ��z�7��
O��kW~�S�/ #(QƊ1&�` �`0��u���������/�hbL� �x��� �<��`Y߈
���m'�K<d���'i?{�4�Nt��!�$�,�\�_��*K��NR��j��҅�R;t���o}��?���G�-W�r囟B{�JH&@"��$�9z�/z�x���<����q(0+��3e�eb �`U9s ��١��E���2@C�>��+,��#ƕ���9˧dK�'f����C��Q;��J�-*C�����z{���U�y�O}ʚ75`L�!CbG�#+>e�x��K������a5 "�o��
�1��k�U掝�>`��}�{Q�
F��=ɮ�뙯tE
0�4�8a�÷��f��w�S������4� qx���GtS�O��M+$P�&�Cr������}��m~�Ô���U0X(#��bb�B�#Q���,�j����ˉi
[��'3� �buE��H3�sGt��K$��.�5��$����!�K��5C�b �s Lʣ��i����O��!)G�)�Ms�q>�!�v�ǯ�ËĀ 0���� �`L:���O*V���ى�p����we.N��1fϱ�+� Hfc`������t{fOY��ᙑ�	1��]��W��Уv�( &gĐ`0 ƙ�އ���o��B�LH �鉣�y�����f��k�O��"0 V$�XH � ��dI�����

� ���'�,���:r��Gm0|�82Q����1k�m2t��C:�4�V��d<�6s�!cNh�X^K���+3����T<��@i +V�8c��N:9zw?x��[��v���=�Gv�cCO������5��cR���c�����Bu`�.�^ҟ3u�X �1�b��>'�&��IuO�ST�NX=`d���30��0 �dLAt��.�uve�M�ɽl�U���,�p횿z�w\�2�����m�1T\��^g���{��S�Σ�躵^�m0S��8#N�x"�9ҋ��X�c�Q"q�]�7]pa���t�w?  �<�5oE8���e�ZرTTO��"���������Ĩ�@2&79�+���o���1j�Oo�qd|;��7��m�`L�4QW�I���a�L/�f��?�?��huG��� X)�[#� H�P|��z~]�:��`:}۳�B`�E�&@k�'to���F�l�m8��,���U�Q��S�N2�Ѓ��C͓C�RSrO����(�v��p�T��db��댛�J]dO�k�4�u��_��%e]D�D�L�3�Lj+� �y���i� =u��=��o�N���F:}͋�w�ȡI���t�Fq��}w4͍A��.^p���bF��{R���2d�0�;5O�$�  ��#f��@9QGT�DHbŞ�g����`JSS*�  DR5{~)�õL-3YD� ������D.���U�v�����Tn��<�#������?y�>���񦬲��C�;�!� R2��   c��E���#�bO�4�X�iy�Ť2SK���W�[��ٵ�WK� �R��6� f�<���]zEz�5���ץ�ݼ���~�?��BDeMy' r�M�t�Z��c��9��ӯ  ��� � 	��`H �<bR�t�Z�*1LJ�QD�p��]tw��.� ]ђ�Y�֚��7�A�"a��.�ac��#�6?���Zw�����s]�.��!P�(�ב>�Vtq��� �!b0dF�R@ `�Y
��H����#Hq���<��b�L����R�N?�q��!?,:@b  k�R^�*����K���u����ܳ�X:��ҩW/����t B� ����]`�Y��2�M
*.0��@ �"��b  I���`������YWy��"^?T��5. h 5@$̑=r��nZ��:/����������P��0�>��@  ���f]��������E�"�<QAICR�t � x�~c%E��k�_���&��@q`{  8%��|�"@����G�^L�����������pŷUPC�B� �w�� �Kp�<gd�.[<a�H"!�<V��	�ؓ{bRMŤx ����g��_g_6�����L�: � �Z  M�0o�AG^�n��ir�[P�qŷ���2 #� F T5  �`�e�|��s�1F&Ұ ڠ�+�� ��$%	��
���]vGζ�[#��`���r�i`��� @�XM �60M�-�]���Ʈ��9`r�gG9� F0Z�u��nA  ��p�;F&���:n�vêSn��{C�XKT��r,�*ֈ�
y��M,�,�"re*�����@�5QvG����n�R\��  ����[������ p��ՐA
L��s;{U�#   O����!�i�"�%��OH$
D���4��[uIU�� =ž �-)��� m ���[�^�m ����3/ `����
���� � mS�*  �� ����Q��)l�' ����� �US����_��d�0�W 4��^ �\�YMݼ P �$  ��&]W%��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://5gi6k4qlppsx"
path="res://.godot/imported/index.icon.png-5665fad188e88d1e882500a4376bfe02.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://index.icon.png"
dest_files=["res://.godot/imported/index.icon.png-5665fad188e88d1e882500a4376bfe02.ctex"]

[params]

compress/mode=0
compress/high_quality=false
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
�Ǫ��GST2      X     ����                X       �,  RIFF�,  WEBPVP8L�,  /Õ�mۆq�����1�Ve���G�N^6۶�'�����L �	���������'�G�n$�V����p����̿���H�9��L߃�E۶c��ۘhd�1�Nc��6���I܁���[�(�#�m�9��'�mۦL���f�����~�=��!i�f��&�"�	Y���,�A����z����I�mmN����#%)Ȩ��b��P
��l"��m'���U�,���FQ�S�m�$�pD��жm�m۶m#�0�F�m�6����$I�3���s�������oI�,I�l���Cn����Bm&�*&sӹEP���|[=Ij[�m۝m��m���l۶m��g{gK�jm���$�vۦ�W=n�  q��I$Ij�	�J�x����U��޽�� I�i[up�m۶m۶m۶m۶m�ټ�47�$)Ι�j�E�|�C?����/�����/�����/�����/�����/�����/�����/�����̸k*�u����j_R�.�ΗԳ�K+�%�=�A�V0#��������3��[ނs$�r�H�9xޱ�	T�:T��iiW��V�`������h@`��w�L�"\�����@|�
a2�T� ��8b����~�z��'`	$� KśϾ�OS��	���;$�^�L����α��b�R鷺�EI%��9  �7� ,0 @Nk�p�Uu��R�����Ω��5p7�T�'`/p����N�گ�
�F%V�9;!�9�)�9��D�h�zo���N`/<T�����֡cv��t�EIL���t  �qw�AX�q �a�VKq���JS��ֱ؁�0F�A�
�L��2�ѾK�I%�}\ �	�*�	1���i.'���e.�c�W��^�?�Hg���Tm�%�o�
oO-  x"6�& `��R^���WU��N��" �?���kG�-$#���B��#���ˋ�銀�z֊�˧(J�'��c  ��� vNmŅZX���OV�5X R�B%an	8b!		e���6�j��k0C�k�*-|�Z  ��I� \���v  ��Qi�+PG�F������E%����o&Ӎ��z���k��;	Uq�E>Yt�����D��z��Q����tɖA�kӥ���|���1:�
v�T��u/Z�����t)�e����[K㡯{1<�;[��xK���f�%���L�"�i�����S'��󔀛�D|<�� ��u�={�����L-ob{��be�s�V�]���"m!��*��,:ifc$T����u@8 	!B}� ���u�J�_  ��!B!�-� _�Y ��	��@�����NV]�̀����I��,|����`)0��p+$cAO�e5�sl������j�l0 vB�X��[a��,�r��ς���Z�,| % ȹ���?;9���N�29@%x�.
k�(B��Y��_  `fB{4��V�_?ZQ��@Z�_?�	,��� � ��2�gH8C9��@���;[�L�kY�W�
*B@� 8f=:;]*LQ��D
��T�f=�` T����t���ʕ�￀�p�f�m@��*.>��OU�rk1e�����5{�w��V!���I[����X3�Ip�~�����rE6�nq�ft��b��f_���J�����XY�+��JI�vo9��x3�x�d�R]�l�\�N��˂��d�'jj<����ne������8��$����p'��X�v����K���~ � �q�V������u/�&PQR�m����=��_�EQ�3���#����K���r  ��J	��qe��@5՗�/# l:�N�r0u���>��ׁd��ie2� ���G'& �`5���s����'����[%9���ۓ�Хމ�\15�ƀ�9C#A#8%��=%�Z%y��Bmy�#�$4�)dA�+��S��N}��Y�%�Q�a�W��?��$�3x $��6��pE<Z�Dq��8���p��$H�< �֡�h�cާ���u�  �"Hj$����E%�@z�@w+$�	��cQ��
1�)��������R9T��v�-  xG�1�?����PO�}Eq�i�p�iJ@Q�=@�ݹ:t�o��{�d`5�����/W^�m��g���B~ h�  ����l  נ�6rߙ�����^�?r���   ���⤖��  �!��#�3\?��/  �ݝRG��\�9;6���}P6������K>��V̒=l��n)��p	 ����0n䯂���}   ���S*	 ��t%ͤ+@�����T�~��s����oL)�J� 0>��W�-  �*N�%x=�8ikfV^���3�,�=�,}�<Z��T�+'��\�;x�Y���=���`}�y�>0����/'ـ�!z9�pQ��v/ֶ�Ǜ����㗬��9r���}��D���ל���	{�y����0&�Q����W��y ����l��.�LVZ��C���*W��v����r���cGk�
^�Ja%k��S���D"j���2���RW/������ض1 ����
.bVW&�gr��U\�+���!���m ;+۞�&�6]�4R�/��Y�L�Ά`"�sl,Y/��x��|&Dv�_
Q*� V�NWYu�%��-�&D�(&��"  Wc��ZS���(�x� ,�!����!�L�AM�E�]}X�!��wB�o��-  �-���16���i���ю�z��� ���B��oB�0������v]���ȓ�����3�� +S�χ�=Q_�����˨�d��|)D>��k ��uȣ���Y[9̂�����! ^�!��r���j0Y+i��΍e(�ț� ���x��
��{��<6 R���پ�b��Y
C����+���������;���a ���,�o��bC�{�?���1 �(��¤ �V�������;�=��I��� ���EI���Z��)D����t=S ��] X��9K�= �.~�K[��Ŋ��,2��� p}>w<n�g h�
�t���R�u�G�1k���!��x���������� �L���|>D�0�Ǣ(Qc�� ����= �ۊ�Z0�^��c �
|�����L�%�d��q���(�WB� ��(	���� �J��8D�0�~$�Dsy�Ѿ!������j�^ ��mOa�8.�qce��s|%Dq~,X�u�������=T	���Q�M�ȣm�Y�%Y+�[�0|"DΞ�j�u�L6�(Qe��qw�V�э���ǂ���!j�K � �:�wQ�dÛ������R�
��C���X�u�`����\"j讀Dq21� �F>B[��[������]@K-���C�e�q�tWP�:W�۞X�z��,��t�p���P��Se����T���{dG��
KA���w�t3t��[ܘ�4^>�5ŉ�^�n�Eq�U��Ӎ��α�v�O6C�
�F%�+8eů��M����hk��w�欹񔈓����C��y訫���J�Is�����Po|��{�Ѿ)+~�W��N,�ů��޽���O��J�_�w��N8����x�?�=X��t�R�BM�8���VSyI5=ݫ�	-�� �ֶ��oV�����G������3��D��aEI��ZI5�݋����t��b��j��G����U���΃�C�������ق�в����b���}s����xkn��`5�����>��M�Ev�-�͇\��|�=� '�<ތ�Ǜ���<O�LM�n.f>Z�,~��>��㷾�����x8���<x�����h}��#g�ж��������d�1xwp�yJO�v�	TV����گ�.�=��N����oK_={?-����@/�~�,��m ��9r.�6K_=�7#�SS����Ao�"�,TW+I��gt���F�;S���QW/�|�$�q#��W�Ƞ(�)H�W�}u�Ry�#���᎞�ͦ�˜QQ�R_��J}�O���w�����F[zjl�dn�`$� =�+cy��x3������U�d�d����v��,&FA&'kF�Y22�1z�W!�����1H�Y0&Ӎ W&^�O�NW�����U����-�|��|&HW������"�q����� ��#�R�$����?�~���� �z'F��I���w�'&����se���l�̂L�����-�P���s��fH�`�M��#H[�`,,s]��T����*Jqã��ł�� )-|yč��G�^J5]���e�hk�l;4�O��� ���[�������.��������������xm�p�w�չ�Y��(s�a�9[0Z�f&^��&�ks�w�s�_F^���2΂d��RU� �s��O0_\읅�,���2t�f�~�'t�p{$`6���WĽU.D"j�=�d��}��}���S["NB�_MxQCA[����\	�6}7Y����K���K6���{���Z۔s�2 �L�b�3��T��ݹ����&'ks����ܓ�ЛϾ�}f��,�Dq&������s��ϼ��{������&'k�����Qw窭�_i�+x�6ڥ��f�{j)���ퟎƍ3ou�R�Y����徙�k����X�Z
m.Y+=Z��m3�L47�j�3o�=�!J
5s���(��A ��t)���N�]68�u< Ƞ��_�im>d ��z(���(��⤶�� �&�ۥ� ��  Vc�8�'��qo9 �t��i�ρdn��Of���O�RQP���h'������P֡���n ���č����k�K@�>����pH>z)-|��B��j���!j:�+������˧��t�������1����.`v�M�k�q#�$���N:�����-M5a10y����(�T��� X5 \�:� ?+�7#�?�*Y+-,s� ~�|\)뀀ap �drn�g��RN�X�er ��@ĕ���;��z��8ɱ�����	�- �
�bKc����kt�U]�䎚���hgu���|�_J{ �`p��o�p�T�U��p���/���Hϑ�H�$X ܬm3���ŉ�U'��뻩t��G9�}�)O������p�΃g���JO���\9�׫�����ڳ�!k����/��9R���^�%��C����T���;ji<�>�KY����;�J��ƶm .P��pT��
@HA��r��98V���b�v���YwaZ>�$oւ?-փ��ʹ|0�.��3���b駁�c��;?8E;���V�B�؀����|%\\s��%����e{o��Z�i�������^���s�Jx������B jh�\ �h�<��V��sh@:���.�ІYl��˂�`3hE.,P�2^����J��+�����p��
�ЊJd��x�*�@�7R��� �"�G="!�� �p����u�o��wV�m�g���~F��?����/�����}~����sо7� ���\,,k�J�T�6������Z�y�rBZ[D�>v�HQ�R��mq�������DD�-6+�V`���J�E�����\� 9!ߑ�`��6���ml�~ZM�Z�ȎV���g���������3?*u3���ctW����YQa�Cb�P�,B5�p0�m�cͺEt�{,��>s9f�^��`OG��]����2�Fk�9_�G�vd��	��)��=�1^Ų�Wl3{�����1��H)�e������9�هZ�]}�b���)b�C��es}�cVi~x���e
Z�)܃��39������C�(�+R����!�j����F�n���<?�p��l�8a�4xOb��������c�8&�UA�|	/l�8�8���3t�6�͏���v���� ����סy�wU��`� =��|M�Y?�'�A��&�@*�c~!�/{��),�>�=xr"	�qlF:��L&���=<5t�h.�#ᣭ���O�z�!�&`A�F�yK=�c<\GZ�� 4HG�0i�F녠uB"���<��c�Jeۈ�3!����O��q萞PiZ&�$M[���(G��e���ؤ���ã��O���5����'�gH~�����=��g�F|8�+�X�4�u���G�2����'��.��5[�OlB��$f4���`��mS�L�,y�t&V�#P�3{ ��763�7N���"��P��I�X��BgV�n�a:$:�FZ���'�7����f������z!�����KA�G��D#������ˑ`ڶs���&� ݱ��4�j��n�� ݷ�~s��F�pD�LE�q+wX;t,�i�y��Y��A�۩`p�m#�x�kS�c��@bVL��w?��C�.|n{.gBP�Tr��v1�T�;"��v����XSS��(4�Ύ�-T�� (C�*>�-
�8��&�;��f;�[Փ���`,�Y�#{�lQ�!��Q��ّ�t9����b��5�#%<0)-%	��yhKx2+���V��Z� �j�˱RQF_�8M���{N]���8�m��ps���L���'��y�Ҍ}��$A`��i��O�r1p0�%��茮�:;�e���K A��qObQI,F�؟�o��A�\�V�����p�g"F���zy�0���9"� �8X�o�v����ߕڄ��E �5�3�J�ص�Ou�SbVis�I���ص�Z���ڒ�X��r�(��w��l��r"�`]�\�B���Ija:�O\���/�*]�þR������|���ʑ@�����W�8f�lA���Xl��촻�K<�dq1+x�*U�;�'�Vnl`"_L�3�B����u�����M���'�!-�<;S�F�܊�bSgq� ���Xt�肦�a��RZ�Y_ި��ZRSGA��-:8����yw_}XW�Z���-k�g.U��|�7P�
&���$˳��+��~?7�k�bQ���g������~�Z�e����H�-p�7S�� 
�w"XK�`K%?�`Tr|p���"��\�a�?�٧ ��'u�cv�&��<LM�Ud��T���Ak��������'+7��XR`��[\�-0���e�AiW]�Dk���$u���0[?�-���L����X�ĚSK-�.%�9=j�3t^���(c�yM-��/�ao����\%�?�б �~���b][
tٵ�<qF�)�
�J�'QZY�����*pB�I4�޸�,������.Т�1���/
t�1-1������E�*��Cl/Ю©f�<,0�S�bf�^���[8Z$��@���kw�M<?�[`��)3)1� �U����:��/pR��XV`XE,/0���d���1>ѫ��i�z��*o�}&R{���$f�JV=5͉Ύ��Rl�/�N4.�U~Cm�N~��HPRS�?G��g�-���qvT{�G _�[ua�;���kco�9�Kw����n����E{d�j��C���,q����Y���cwY<$#�ؤ�m+�LL-�z� �y<{/7���[��X�?�-6(cO ?�XZ�M�������sb�[
�.����j|;d�!0lCIqZ�z�&��~�|7�A���A~��á@�� 417��}t ��,� X�6��lS)6v�G
��I:�).~��8R���#'��߶;9�'���U�$1nC�L��찦3�+b黙u�NJ�����8���X�?5�0��^��[B/+�0�Ur(��J��+Xr�H�����HZm&�#�p	�Y ����*���hM]��m���b�ݢ����G����s��z-�x��������� �J�"���Ћ�g�Ҝ �Aа��?��?6��c�Zx�$�t��{s
-R�E�24�?�{�l�-��1�3S�EJ��v6X]L�B^ ��]N��R�yN��62�����'R�p-�����n2�d�?Th|�h��3X������Rc8&��_,��;T�8�� �hΗv�(7I;�3Obn;��O�!����Lߍ*�E~wU,���n�MN1���Z��Y̖��tY;5�^�<Z�Ǩ�T#�bt�xfA�n�cq����"9GD*�^JL��HJ���4���V�-�܉��4*��u]�[
���,"ҏ�i!�r~L��_�����8 ]j�?x���<k+%w��Bk��=�u�ڤ��>%2Bۃ�Y�n<jBo������Κ�0M~�t>�#b/jZ�}���B��Q��#���6R$v�����k�R$c/:�~���(V�7;)��ߊ[̣0?F��;.�*ݪd������{A`w>~�i=D�c��������Y2�X�q~�r2��8@v=f�?��X��S�"X�j?��@$?�����x�(�k���c7��\�����>A�=fpM?9d?�׻{���)f�.⪝���3�������f,N;"��,N���X��*�"V���"��C��?���(2=���A��1�Ul���h�8Ao(5X�B�X�>S�j��s�!
l����GgGp��>�v;c���V�N1���-��K�S�=6PiN�fNq������,
�3SWx�ei����f'�*�r�rʹ̙�e�7���b�o���>_i��M�_��V�p�r�9��X�$�����B���t5�4#�B(E���3�������`����I�M�e��b6_����{~�f/��@��B��Y����E�4��޲�d�O�$���M�����ݖv�P����TR�oj~��+}��#���"�]1Υ_���nR���œ����^pQ2�7첾b��3�ba�\��uu2�~O�G�����5�^>v������m��?���mC;$eT��C񎋋��V��8�:��
���ʱlt��~e]�cC7dl���.�i����\w����/..F�Q5���œ��`�o���E����E�͛�ٽ-�o�z�"n��/��[�����ͳI���S��Dڢ��V�6��!��esq��AC���ڻ���OMk�y��{7`c0�ٺ���5C5�yiw��`ps�OC��f�X�5oQ�\_*m�f�)稹"���a2$O;�]C�A�;V.���c��iޢ�R5�X��t%�s����ȸ�; 5�����)��X|?����9&��wĽjdn�{��7��/����q]3Ɲ�}�[��yF~�Q0����x��U�� ���˘?����a�;���/yޫ�����6.��C}���&L��9�_�ս�w�o���W�^�;�^u�xoݖ��Q8����4��kW��'����:9>����Xp5H��ONtL��=��_�&�0��H"Q��|H���4!���]�'�!޹Eܢ���}=soϢ~	K�$���`"!]j�+{'e�M��D]��=�>c��xS��Y����X��7�7+�Me̯/���u�Q����i���Eg�9�g�RU��#'��ޑW\r�aS�/3�"/v
IgX���}ٻ���ʏr�r���_��<�6�Gʋ&���z%�Pl^d����㑭v�ʎو�w�[���Q��k�K�����IWˈ��`/�Y�X��9J"��_��V{��je�i��6�<�ZS��� �t���W�Bg��@5���..��X�eʡ��*�HRgkD^>�y裝"�9�+wQ4ABR������^�k3�>2�����x�C�l���f:��#gщ�s� ��ߜ��ȁ���+���A��˾�g�1K9Cܹ��:���T"!I������Hs�;���ue��9@#ChE5&!��'�2�����w*a/Q��I	�E������I�w�����?��v })B��GQ�n�h"]0��]Z֑���.}�&~x2��
eĞsF�n�+�b�e�i����0Ix�y��Aѕ���
[1�B�R$$����:�4E疳��#�4���y���ӈ�6o1O�V'��7]�H�.)/)�OwW./�g�l��£���"$d���}[���t���U~�MQԲ�$��~��c��S�M�a���ш=��diH��(N�+U�D����f"V�"�����.ƈ�#Ͼ�eH:�x��d!k 6�J�f9�GW�4����Kp��T��3��~��G�؀��,�zZ��澰؋7����v#� &�r+O�@Ud7͐�$�\�D�O��W_�Ew�ͻ�7��oD����y��,��Ƣ�cƙd	���U�u�:�#�h6]�R
�U~	V�՟R�V������/�:r�F¬�k?|Ī�r\�<.�^9����?��]Aʻ�iT;vg�PpyM���1��},�dY\e8��I��2�wjM��S/�p�1�\^�6$4�F��(:�\nۢ�2�}�Pm�X�'.����U�3��bq�nXK�i_BD�_H}�r;Y^�t�<���o��#gw��2q_�|�^�<��E�h���O�����R�-Ɖ���S�	!��z�1�+iH�1G���+<����~�;|�F�{�}v�;s�j�Q;�٩�;&f�}�������tL ���#��Ъ>;��z���?U˽�~������e��{K%��/:F�/<�n�2k�8�x��S-�5�`��ԗ�H�{���R�y�S�(w��ѥe
�	0���w�޻�U1��7V-Q�̶ꪸ�g�X��3V&�T[+)b����2���(���B��,��z����9���B`��!��o�ע(�W�RZ���m��%/V�&��|g��f��*[_��nn��M�M`�%��)��Z�K$�����F�� ��$r^�k�K,	u;w������X���;�L�eoI�6��y%����~����)���0"�zc�BH�<�kW�E\.�b��R>mٺ��<����͑Թ���a=2X���=/��_;	Ρ�e&o.����]��2!�嫈�"I������j�höR��͒\L�0�e������,)ýf�; ��E��0��<%�Q�Aø�x8�� �]eQL�;|���꼬z�W2
�H�z�_��
/K`J�O�O�Y�~j���>����d�v��%�ެ7�4{%��٥7Z��>����|��5^�\ױ���:��Z^;��U��s�)��#�|�.̡���R2��j����şBб���*cMvD�W^{�������m�D��0�,������#���?O����
����?z�{ȓ'�|����/�����/�����/�����/�����/�����/�����/�����/|� �%
'��i�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ke4dh24fljfs"
path="res://.godot/imported/index.png-5122033cac747157decad52589e2295c.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://index.png"
dest_files=["res://.godot/imported/index.png-5122033cac747157decad52589e2295c.ctex"]

[params]

compress/mode=0
compress/high_quality=false
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
��F�extends Node

func _on_TabContainer_tab_selected(tab):
	
	match tab:
		0:
			get_window().set_size(Vector2(450, 220))
		1:
			get_node("TabContainer/Average Time").updateWindowSize()
		2:
			get_node("TabContainer/Route Finder").adjustWindowSize()
�h��) RSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Main.gd ��������   PackedScene %   res://SegmentTimer/SegmentTimer.tscn $����{   PackedScene #   res://AverageTime/AverageTime.tscn �lN��X   PackedScene #   res://RouteFinder/RouteFinder.tscn  ���h�p      local://PackedScene_4lw40 �         PackedScene          	         names "         Main    script    Node    TabContainer    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    size_flags_horizontal    size_flags_vertical    Segment Timer    visible    layout_mode    Average Time    Route Finder    _on_TabContainer_tab_selected    tab_selected    	   variants    	                        �?                                                    node_count             nodes     ?   ��������       ����                            ����                                 	      
                 ���                                ���                                ���                               conn_count             conns                                      node_paths              editable_instances              version             RSRC�$Lp�X�_n{
  "World": {
    "Tallon Overworld": {
      "Alcove": {
        "Landing Site": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Arbor Chamber": {
        "Root Cave": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Artifact Temple": {
        "Temple Lobby": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Biohazard Containment": {
        "Deck Beta Transit Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Deck Beta Security Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Biotech Research Area 1": {
        "Deck Beta Security Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Deck Beta Conduit Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Canyon Cavern": {
        "Landing Site": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Tallon Canyon": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Cargo Freight Lift to Deck Gamma": {
        "Reactor Access": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Deck Beta Transit Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Connection Elevator to Deck Beta": {
        "Deck Beta Conduit Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Hydro Access Tunnel": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Deck Beta Conduit Hall": {
        "Biotech Research Area 1": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Connection Elevator to Deck Beta": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Deck Beta Security Hall": {
        "Biohazard Containment": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Biotech Research Area 1": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Deck Beta Transit Hall": {
        "Cargo Freight Lift to Deck Gamma": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Biohazard Containment": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Frigate Access Tunnel": {
        "Frigate Crash Site": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Main Ventilation Shaft Section C": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Frigate Crash Site": {
        "Waterfall Cavern": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Overgrown Cavern": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Frigate Access Tunnel": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        }
      },
      "Great Tree Chamber": {
        "Great Tree Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Great Tree Hall": {
        "Transport Tunnel D": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Great Tree Chamber": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Life Grove Tunnel": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Transport Tunnel E": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Hydro Access Tunnel": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Gully": {
        "Landing Site": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Tallon Canyon": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Hydro Access Tunnel": {
        "Connection Elevator to Deck Beta": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Great Tree Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Landing Site": {
        "Alcove": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Canyon Cavern": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Gully": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Temple Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Waterfall Cavern": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Life Grove": {
        "Life Grove Tunnel": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Life Grove Tunnel": {
        "Great Tree Hall": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Life Grove": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Main Ventilation Shaft Section A": {
        "Main Ventilation Shaft Section B": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Reactor Core": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Main Ventilation Shaft Section B": {
        "Main Ventilation Shaft Section A": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Main Ventilation Shaft Section C": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Main Ventilation Shaft Section C": {
        "Frigate Access Tunnel": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Main Ventilation Shaft Section B": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Overgrown Cavern": {
        "Frigate Crash Site": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Transport Tunnel C (Tallon)": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        }
      },
      "Reactor Access": {
        "Reactor Core": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Cargo Freight Lift to Deck Gamma": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Savestation": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Reactor Core": {
        "Main Ventilation Shaft Section A": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Reactor Access": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Root Cave": {
        "Arbor Chamber": {
          "World": "Tallon Overworld",
          "Door": "Plasma"
        },
        "Root Tunnel": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Transport Tunnel B (Tallon)": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Root Tunnel": {
        "Tallon Canyon": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Root Cave": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Savestation": {
        "Reactor Access": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Tallon Canyon": {
        "Canyon Cavern": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Gully": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Root Tunnel": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Transport Tunnel A (Tallon)": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Temple Hall": {
        "Landing Site": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Temple Security Station": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Temple Lobby": {
        "Artifact Temple": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Temple Security Station": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Temple Security Station": {
        "Temple Hall": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Temple Lobby": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Transport to Chozo Ruins East": {
        "Transport Tunnel C (Tallon)": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Transport to Tallon Overworld East": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Transport to Chozo Ruins South": {
        "Transport Tunnel D": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Transport to Tallon Overworld South (Chozo)": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Transport to Chozo Ruins West": {
        "Transport Tunnel A (Tallon)": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Transport to Tallon Overworld North": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Transport to Magmoor Caverns East": {
        "Transport Tunnel B (Tallon)": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Transport to Tallon Overworld West": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Transport to Phazon Mines East": {
        "Transport Tunnel E": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Transport to Tallon Overworld South (Mines)": {
          "World": "Phazon Mines",
          "Door": "Power"
        }
      },
      "Transport Tunnel A (Tallon)": {
        "Tallon Canyon": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Transport to Chozo Ruins West": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Transport Tunnel B (Tallon)": {
        "Root Cave": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Transport to Magmoor Caverns East": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Transport Tunnel C (Tallon)": {
        "Overgrown Cavern": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Transport to Chozo Ruins East": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        }
      },
      "Transport Tunnel D": {
        "Great Tree Hall": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Transport to Chozo Ruins South": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        }
      },
      "Transport Tunnel E": {
        "Great Tree Hall": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        },
        "Transport to Phazon Mines East": {
          "World": "Tallon Overworld",
          "Door": "Ice"
        }
      },
      "Waterfall Cavern": {
        "Landing Site": {
          "World": "Tallon Overworld",
          "Door": "Power"
        },
        "Frigate Crash Site": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      }
    },
    "Chozo Ruins": {
      "Antechamber": {
        "Reflecting Pool": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        }
      },
      "Arboretum": {
        "Arboretum Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Gathering Hall Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Sunchamber Lobby": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Arboretum Access": {
        "Ruined Fountain": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Arboretum": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Burn Dome": {
        "Burn Dome Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Burn Dome Access": {
        "Burn Dome": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Energy Core": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Crossway": {
        "Crossway Access West": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Crossway Access South": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        },
        "Elder Hall Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Crossway Access South": {
        "Crossway": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        },
        "Hall of the Elders": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        }
      },
      "Crossway Access West": {
        "Furnace": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Crossway": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        }
      },
      "Dynamo": {
        "Dynamo Access (Chozo)": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Dynamo Access (Chozo)": {
        "Dynamo": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Watery Hall": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "East Atrium": {
        "Gathering Hall": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Energy Core Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "East Furnace Access": {
        "Furnace": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        },
        "Hall of the Elders": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        }
      },
      "Elder Chamber": {
        "Hall of the Elders": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        }
      },
      "Elder Hall Access": {
        "Crossway": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Hall of the Elders": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Energy Core": {
        "Burn Dome Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Energy Core Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "West Furnace Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Energy Core Access": {
        "East Atrium": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Energy Core": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Eyon Tunnel": {
        "Nursery Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Ruined Nursery": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Furnace": {
        "West Furnace Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Crossway Access West": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "East Furnace Access": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        }
      },
      "Gathering Hall": {
        "Gathering Hall Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Watery Hall Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "East Atrium": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Save Station 2": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Gathering Hall Access": {
        "Arboretum": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Gathering Hall": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Hall of the Elders": {
        "East Furnace Access": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        },
        "Crossway Access South": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        },
        "Elder Hall Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Elder Chamber": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        },
        "Reflecting Pool Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Hive Totem": {
        "Totem Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport Access North": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Magma Pool": {
        "Meditation Fountain": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Training Chamber Access": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        }
      },
      "Main Plaza": {
        "Ruins Entrance": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Ruined Shrine Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Piston Tunnel": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Ruined Fountain Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Nursery Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Plaza Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Map Station (Chozo)": {
        "Ruined Gallery": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Meditation Fountain": {
        "Ruined Fountain": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Magma Pool": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "North Atrium": {
        "Ruined Nursery": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Ruined Gallery": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Nursery Access": {
        "Main Plaza": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Eyon Tunnel": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Piston Tunnel": {
        "Main Plaza": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Training Chamber": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Plaza Access": {
        "Main Plaza": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Vault": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Reflecting Pool": {
        "Reflecting Pool Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Antechamber": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Save Station 3": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport Access South": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Reflecting Pool Access": {
        "Hall of the Elders": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Reflecting Pool": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Ruined Fountain": {
        "Ruined Fountain Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Arboretum Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Meditation Fountain": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Ruined Fountain Access": {
        "Main Plaza": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Ruined Fountain": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Ruined Gallery": {
        "North Atrium": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Totem Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Map Station (Chozo)": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Ruined Nursery": {
        "Eyon Tunnel": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "North Atrium": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Save Station 1": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Ruined Shrine": {
        "Ruined Shrine Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Tower of Light Access": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        }
      },
      "Ruined Shrine Access": {
        "Main Plaza": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Ruined Shrine": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Ruins Entrance": {
        "Main Plaza": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Tallon Overworld North": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Save Station 1": {
        "Ruined Nursery": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Save Station 2": {
        "Gathering Hall": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Save Station 3": {
        "Reflecting Pool": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Tallon Overworld East": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Sun Tower": {
        "Sun Tower Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Magmoor Caverns North": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Sun Tower Access": {
        "Sunchamber": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Sun Tower": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Sunchamber": {
        "Sunchamber Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Sun Tower Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Sunchamber Access": {
        "Sunchamber": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Sunchamber Lobby": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Sunchamber Lobby": {
        "Sunchamber Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Arboretum": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Totem Access": {
        "Ruined Gallery": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Hive Totem": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Tower Chamber": {
        "Tower of Light": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        }
      },
      "Tower of Light": {
        "Tower Chamber": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        },
        "Tower of Light Access": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        }
      },
      "Tower of Light Access": {
        "Ruined Shrine": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Tower of Light": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        }
      },
      "Training Chamber": {
        "Training Chamber Access": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        },
        "Piston Tunnel": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Training Chamber Access": {
        "Training Chamber": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        },
        "Piston Tunnel": {
          "World": "Chozo Ruins",
          "Door": "Wave"
        }
      },
      "Transport Access North": {
        "Hive Totem": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Magmoor Caverns North": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Transport Access South": {
        "Reflecting Pool": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Tallon Overworld South (Chozo)": {
          "World": "Chozo Ruins",
          "Door": "Ice"
        }
      },
      "Transport to Magmoor Caverns North": {
        "Transport Access North": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Sun Tower": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Vault Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Chozo Ruins North": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Transport to Tallon Overworld East": {
        "Save Station 3": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Chozo Ruins East": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Transport to Tallon Overworld North": {
        "Ruins Entrance": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Chozo Ruins West": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Transport to Tallon Overworld South (Chozo)": {
        "Transport Access South": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Chozo Ruins South": {
          "World": "Tallon Overworld",
          "Door": "Power"
        }
      },
      "Vault": {
        "Plaza Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Vault Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Vault Access": {
        "Vault": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Transport to Magmoor Caverns North": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Watery Hall": {
        "Watery Hall Access": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Dynamo Access (Chozo)": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Watery Hall Access": {
        "Gathering Hall": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Watery Hall": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "West Furnace Access": {
        "Energy Core": {
          "World": "Chozo Ruins",
          "Door": "Power"
        },
        "Furnace": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      }
    },
    "Magmoor Caverns": {
      "Burning Trail": {
        "Save Station Magmoor A": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Lake Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport to Chozo Ruins North": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Fiery Shores": {
        "Transport Tunnel B (Magmoor)": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Shore Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Geothermal Core": {
        "North Core Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "South Core Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Plasma Processing": {
          "World": "Magmoor Caverns",
          "Door": "Ice"
        }
      },
      "Lake Tunnel": {
        "Burning Trail": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Lava Lake": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Lava Lake": {
        "Lake Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Pit Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Magmoor Workstation": {
        "South Core Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport Tunnel C (Magmoor)": {
          "World": "Magmoor Caverns",
          "Door": "Wave"
        },
        "Workstation Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Monitor Station": {
        "Monitor Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Shore Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Warrior Shrine": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport Tunnel A (Magmoor)": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Monitor Tunnel": {
        "Triclops Pit": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Monitor Station": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "North Core Tunnel": {
        "Twin Fires": {
          "World": "Magmoor Caverns",
          "Door": "Wave"
        },
        "Geothermal Core": {
          "World": "Magmoor Caverns",
          "Door": "Wave"
        }
      },
      "Pit Tunnel": {
        "Lava Lake": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Triclops Pit": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Plasma Processing": {
        "Geothermal Core": {
          "World": "Magmoor Caverns",
          "Door": "Plasma"
        }
      },
      "Save Station Magmoor A": {
        "Burning Trail": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Save Station Magmoor B": {
        "Transport to Phendrana Drifts South": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Shore Tunnel": {
        "Monitor Station": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Fiery Shores": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "South Core Tunnel": {
        "Geothermal Core": {
          "World": "Magmoor Caverns",
          "Door": "Wave"
        },
        "Magmoor Workstation": {
          "World": "Magmoor Caverns",
          "Door": "Wave"
        }
      },
      "Storage Cavern": {
        "Triclops Pit": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Transport to Chozo Ruins North": {
        "Burning Trail": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport to Magmoor Caverns North": {
          "World": "Chozo Ruins",
          "Door": "Power"
        }
      },
      "Transport to Phazon Mines West": {
        "Workstation Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Ice"
        },
        "Transport to Magmoor Caverns South (Mines)": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Transport to Phendrana Drifts North": {
        "Transport Tunnel A (Magmoor)": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport to Magmoor Caverns West": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Transport to Phendrana Drifts South": {
        "Transport Tunnel C (Magmoor)": {
          "World": "Magmoor Caverns",
          "Door": "Wave"
        },
        "Save Station Magmoor B": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport to Magmoor Caverns South (Phendrana)": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Transport to Tallon Overworld West": {
        "Transport Tunnel B (Magmoor)": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Twin Fires Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport to Magmoor Caverns East": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Transport Tunnel A (Magmoor)": {
        "Monitor Station": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport to Phendrana Drifts North": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Transport Tunnel B (Magmoor)": {
        "Fiery Shores": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport to Tallon Overworld West": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Transport Tunnel C (Magmoor)": {
        "Magmoor Workstation": {
          "World": "Magmoor Caverns",
          "Door": "Wave"
        },
        "Transport to Phendrana Drifts South": {
          "World": "Magmoor Caverns",
          "Door": "Wave"
        }
      },
      "Triclops Pit": {
        "Pit Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Storage Cavern": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Monitor Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Twin Fires": {
        "Twin Fires Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "North Core Tunnel": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Twin Fires Tunnel": {
        "Transport to Tallon Overworld West": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Twin Fires": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Warrior Shrine": {
        "Monitor Station": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Fiery Shores": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        }
      },
      "Workstation Tunnel": {
        "Magmoor Workstation": {
          "World": "Magmoor Caverns",
          "Door": "Power"
        },
        "Transport to Phazon Mines West": {
          "World": "Magmoor Caverns",
          "Door": "Ice"
        }
      }
    },
    "Phendrana Drifts": {
      "Aether Lab Entryway": {
        "Research Lab Aether": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "East Tower": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Canyon Entryway": {
        "Ice Ruins West": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Phendrana Canyon": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Chamber Access": {
        "Hunter Cave": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Gravity Chamber": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Chapel of the Elders": {
        "Chapel Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Chapel Tunnel": {
        "Chapel of the Elders": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Chozo Ice Temple": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Chozo Ice Temple": {
        "Chapel Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Temple Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Control Tower": {
        "East Tower": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "West Tower": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Courtyard Entryway": {
        "Ice Ruins West": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Ruined Courtyard": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "East Tower": {
        "Control Tower": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Aether Lab Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Frost Cave": {
        "Frost Cave Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Upper Edge Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Save Station C": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Frost Cave Access": {
        "Frozen Pike": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Frost Cave": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Frozen Pike": {
        "Hunter Cave Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Frost Cave Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Pike Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Transport Access (Phendrana)": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Gravity Chamber": {
        "Chamber Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Lake Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Hunter Cave": {
        "Hunter Cave Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Chamber Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Lake Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Lower Edge Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Hunter Cave Access": {
        "Frozen Pike": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Hunter Cave": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Hydra Lab Entryway": {
        "Research Entrance": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Research Lab Hydra": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Ice Ruins Access": {
        "Ice Ruins East": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Phendrana Shorelines": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Ice Ruins East": {
        "Ice Ruins Access": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Plaza Walkway": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Ice Ruins West": {
        "Ruins Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Canyon Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Courtyard Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Lake Tunnel": {
        "Hunter Cave": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Gravity Chamber": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Lower Edge Tunnel": {
        "Hunter Cave": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Phendrana's Edge": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Map Station (Phendrana)": {
        "Research Entrance": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "North Quarantine Tunnel": {
        "Quarantine Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Quarantine Cave": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Observatory": {
        "Observatory Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "West Tower Entrance": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Save Station D": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Observatory Access": {
        "Research Lab Hydra": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Observatory": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Phendrana Canyon": {
        "Canyon Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Phendrana Shorelines": {
        "Shoreline Entrance": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Ice Ruins Access": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Plaza Walkway": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Save Station B": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Ruins Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Temple Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Phendrana's Edge": {
        "Storage Cave": {
          "World": "Phendrana Drifts",
          "Door": "Plasma"
        },
        "Security Cave": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Upper Edge Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Lower Edge Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Pike Access": {
        "Frozen Pike": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Research Core": {
          "World": "Phendrana Drifts",
          "Door": "Ice"
        }
      },
      "Plaza Walkway": {
        "Ice Ruins East": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Phendrana Shorelines": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Quarantine Access": {
        "Ruined Courtyard": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "North Quarantine Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Quarantine Cave": {
        "North Quarantine Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "South Quarantine Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Quarantine Monitor": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Quarantine Monitor": {
        "Quarantine Cave": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Research Core": {
        "Pike Access": {
          "World": "Phendrana Drifts",
          "Door": "Ice"
        },
        "Research Core Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Research Core Access": {
        "Research Core": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Research Lab Aether": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Research Entrance": {
        "Speciman Storage": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Hydra Lab Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Map Station (Phendrana)": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Research Lab Aether": {
        "Research Core Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Aether Lab Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Research Lab Hydra": {
        "Hydra Lab Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Observatory Access": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Ruined Courtyard": {
        "Courtyard Entryway": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Save Station A": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Speciman Storage": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Quarantine Access": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Ruins Entryway": {
        "Phendrana Shorelines": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Ice Ruins West": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Save Station A": {
        "Ruined Courtyard": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Save Station B": {
        "Phendrana Shorelines": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Save Station C": {
        "Frost Cave": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Save Station D": {
        "Observatory": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Security Cave": {
        "Phendrana's Edge": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Shoreline Entrance": {
        "Transport to Magmoor Caverns West": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Phendrana Shorelines": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "South Quarantine Tunnel": {
        "Transport to Magmoor Caverns South (Phendrana)": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Quarantine Cave": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Speciman Storage": {
        "Ruined Courtyard": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Research Entrance": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Storage Cave": {
        "Phendrana's Edge": {
          "World": "Phendrana Drifts",
          "Door": "Plasma"
        }
      },
      "Temple Entryway": {
        "Phendrana Shorelines": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Chozo Ice Temple": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Transport Access (Phendrana)": {
        "Transport to Magmoor Caverns South (Phendrana)": {
          "World": "Phendrana Drifts",
          "Door": "Ice"
        },
        "Frozen Pike": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "Transport to Magmoor Caverns South (Phendrana)": {
        "South Quarantine Tunnel": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Transport Access (Phendrana)": {
          "World": "Phendrana Drifts",
          "Door": "Ice"
        },
        "Transport to Phendrana Drifts South": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Transport to Magmoor Caverns West": {
        "Shoreline Entrance": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Transport to Phendrana Drifts North": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "Upper Edge Tunnel": {
        "Frost Cave": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "Phendrana's Edge": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      },
      "West Tower": {
        "Control Tower": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        },
        "West Tower Entrance": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        }
      },
      "West Tower Entrance": {
        "West Tower": {
          "World": "Phendrana Drifts",
          "Door": "Power"
        },
        "Observatory": {
          "World": "Phendrana Drifts",
          "Door": "Wave"
        }
      }
    },
    "Phazon Mines": {
      "Central Dynamo": {
        "Dynamo Access (Mines)": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Quarantine Access A": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Save Station Mines B": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Dynamo Access (Mines)": {
        "Central Dynamo": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Omega Research": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Elevator A": {
        "Elevator Access A": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Elite Control Access": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Elevator Access A": {
        "Elevator A": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Ore Processing": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Elevator Access B": {
        "Metroid Quarantine A": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Elevator B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Elevator B": {
        "Elevator Access B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Fungal Hall Access": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Elite Control": {
        "Elite Control Access": {
          "World": "Phazon Mines",
          "Door": "Wave"
        },
        "Maintenance Tunnel": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Ventilation Shaft": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Elite Control Access": {
        "Elevator A": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Elite Control": {
          "World": "Phazon Mines",
          "Door": "Wave"
        }
      },
      "Elite Quarters": {
        "Elite Quarters Access": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Processing Center Access": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Elite Quarters Access": {
        "Elite Quarters": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Metroid Quarantine B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Elite Research": {
        "Research Access (Mines)": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Security Access B": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Fungal Hall A": {
        "Fungal Hall Access": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Phazon Mining Tunnel": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Fungal Hall Access": {
        "Elevator B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Fungal Hall A": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Fungal Hall B": {
        "Phazon Mining Tunnel": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Missile Station Mines": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Quarantine Access B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Main Quarry": {
        "Quarry Access": {
          "World": "Phazon Mines",
          "Door": "Wave"
        },
        "Save Station Mines A": {
          "World": "Phazon Mines",
          "Door": "Wave"
        },
        "Security Access A": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Waste Disposal": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Maintenance Tunnel": {
        "Elite Control": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Phazon Processing Center": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Map Station Mines": {
        "Omega Research": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Metroid Quarantine A": {
        "Elevator Access B": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Quarantine Access A": {
          "World": "Phazon Mines",
          "Door": "Wave"
        }
      },
      "Metroid Quarantine B": {
        "Quarantine Access B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Save Station Mines C": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Elite Quarters Access": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Mine Security Station": {
        "Security Access A": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Security Access B": {
          "World": "Phazon Mines",
          "Door": "Wave"
        },
        "Storage Depot A": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Missile Station Mines": {
        "Fungal Hall B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Omega Research": {
        "Dynamo Access (Mines)": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Map Station Mines": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Ventilation Shaft": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Ore Processing": {
        "Storage Depot B": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Elevator Access A": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Research Access (Mines)": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Waste Disposal": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Phazon Mining Tunnel": {
        "Fungal Hall A": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Fungal Hall B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Phazon Processing Center": {
        "Maintenance Tunnel": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Processing Center Access": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Transport Access (Mines)": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Processing Center Access": {
        "Phazon Processing Center": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Elite Quarters": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Quarantine Access A": {
        "Central Dynamo": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Metroid Quarantine A": {
          "World": "Phazon Mines",
          "Door": "Wave"
        }
      },
      "Quarantine Access B": {
        "Fungal Hall B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        },
        "Metroid Quarantine B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Quarry Access": {
        "Transport to Tallon Overworld South (Mines)": {
          "World": "Phazon Mines",
          "Door": "Wave"
        },
        "Main Quarry": {
          "World": "Phazon Mines",
          "Door": "Wave"
        }
      },
      "Research Access (Mines)": {
        "Ore Processing": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Elite Research": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Save Station Mines A": {
        "Main Quarry": {
          "World": "Phazon Mines",
          "Door": "Wave"
        }
      },
      "Save Station Mines B": {
        "Central Dynamo": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Save Station Mines C": {
        "Metroid Quarantine B": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Security Access A": {
        "Main Quarry": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Mine Security Station": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Security Access B": {
        "Elite Research": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Mine Security Station": {
          "World": "Phazon Mines",
          "Door": "Wave"
        }
      },
      "Storage Depot A": {
        "Mine Security Station": {
          "World": "Phazon Mines",
          "Door": "Plasma"
        }
      },
      "Storage Depot B": {
        "Ore Processing": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Transport Access (Mines)": {
        "Phazon Processing Center": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Transport to Magmoor Caverns South (Mines)": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Transport to Magmoor Caverns South (Mines)": {
        "Transport Access (Mines)": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Transport to Phazon Mines West": {
          "World": "Phazon Mines",
          "Door": "Power"
        }
      },
      "Transport to Tallon Overworld South (Mines)": {
        "Quarry Access": {
          "World": "Phazon Mines",
          "Door": "Wave"
        },
        "Transport to Phazon Mines East": {
          "World": "Phazon Mines",
          "Door": "Power"
        }
      },
      "Ventilation Shaft": {
        "Elite Control": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Omega Research": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      },
      "Waste Disposal": {
        "Main Quarry": {
          "World": "Phazon Mines",
          "Door": "Ice"
        },
        "Ore Processing": {
          "World": "Phazon Mines",
          "Door": "Ice"
        }
      }
    }
  }
}�|�h+��Q�    ��     (    (   �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       II�                           	                                                                                                                                        
                                                                                                                                                                                                                                                                                                        pp�aa�R66�%                   	                                                                                                             7#""U'&%�110�987�::9�;::�;;9�;;8�;:8�:97�865�663�431�11/�..-�-,,�,,*� �qE.                                                                                                                                                                                                                                                                                tt�%jj��EE�u$$�                                                                                                       %""!Y.-,�<;8�>=;�@?=�A?>�A?>�?>>�?>>�???�>>>�==;�=<:�;:8�:97�875�663�542�321�210�21/�10/�00/�0//�//.�--,�-,*�&%$�yF


                                                                                                                                                                                                                                                                    yy�&ss��EEn�66�aa                    %   &   !                                                         3,,*�::7�A@>�A@>�BA?�BA>�A@>�A@>�A?>�A?>�?>>�?>>�???�>>=�==:�<<9�;:8�986�774�653�441�210�310�20/�1//�0//�///�//.�//-�/0-�0.-�0.-�.-+�--*�A@?�222d%%%                                                                                                                                                                                                                                                            ss� ww��??^�..c�))�O@
         &   .   0   ,   %                                     *++)�==;�@?=�A@=�AA>�A?=�A?>�A@>�AA>�A@>�A?>�A?>�A?>�?>>�?>>�???�>>=�==:�<<9�:97�976�653�542�421�220�20/�20/�0//�0//�//.�//.�//-�00-�0.-�/.,�//,�/.,�.,,�-,+�--*�('%�]                                                                                                                                                                                                                                                    pp�yy��JJo�%%=�**b�##jE

+        ,   6   9   8   /   %         
        Z320�==:�@?=�??=�>=;�@@=�@A=�@><�@?=�A@>�AA=�A@>�A?>�A?>�A?>�?>>�?>>�???�>>=�==:�<;9�:97�875�653�542�320�320�20/�1//�0//�0//�//.�//-�//-�0/-�0.-�/.,�//,�/-,�-,+�--+�--*�-,*�((&���6                                                                                                                                                                                                                                                zz�����__��//C�  7�,,h�^;   #   1   =   C   C   ;   0   $   (|�,,*�;:8�>>:�?><�>=;�=<:�@?<�?@<�?><�@?=�BA?�BA>�A@>�A?>�A?>�A?>�?>>�?>>�>>>�>>=�==;�<<9�;:8�875�653�432�320�310�20/�1//�0//�///�//.�//-�00-�0.-�/.,�/.,�/.,�.,,�-,+�..+�+*(������!�F                                                                                                                                                                                                                                            �����gg��;;]�-�!!<�**j�E0
'   5   C   L   M   GI�%&#� ��541�765�::7�<<9�<<9�==:�>>;�>>;�>=;�@?=�@?=�@@=�A@>�A?>�A?>�@>=�?>>�?>>�>>>�>>=�==;�=<:�;98�875�653�431�320�310�20/�0//�0//�///�//-�//-�0/-�0.-�/.,�//,�/-,�-,,�'&%�����&$#�*)'�,*)�,+*�**)�$$"�A                                                                                                                                                                                                                                        mm�ww��ff��HHu�**E�'�&&G�##gz4=9   I_���  �

	��.-+�10.�441�774�996�;:8�==:�==:�>=;�?><�?><�??<�A@>�@?=�@?=�@>=�?>>�???�>>>�>>=�>>;�=<:�;:8�875�764�432�210�21/�10/�0//�0//�//.�//-�00-�0/-�0.-�/.,�,,)�!����#" �,*)�,+)�,+)�,*)�+))�***�**)�+*)�+*(�$#"�1                                                                                                                                                                                                                                    ==Z	����uu��ZZ��CCb�))=�,�''S�\v${�������%%$�*)'�..+�11.�442�764�::7�;;8�=<:�>=;�>=;�??<�@?=�@?=�@?=�@>=�?>>�???�>>=�>>=�>?<�=<:�;98�:97�764�542�211�21/�10/�0//�///�//.�//-�0/-�0.-�.-+�$$"��
		��''%�-,*�-,*�-+*�,+)�,*)�,*)�+*)�*)(�*)(�*)(�+*(�+*)�*((��                                                                                                                                                                                                                                ::Yxx��tt��\\��KKm�==Y�''8�!!2�..P�++N�)����		���"! �&&$�**(�..,�210�542�885�;:8�<;9�=<:�??<�@?=�@>=�GFC�WWQ�jjb�vxl���v�������������������������������z�{~n�nnb�acW�RSK�@@;�22/�//,�)('��			��)('�--*�-,*�-,*�-+*�-+*�,+)�,*)�+))�*))�**(�*)(�**(�+)(�+*)�+*)�-,*�)'&�Q                                                                                                                                                                                                                                88^
��������gg��WWu�PPm�AAV�%%1�""3�11X�$#E��������"" �&&$�+*)�//,�330�764�986�CB?�[]U�yyn��������������ɰ��ʹ��ʹ��͵��͵��ʹ��˲��ɱ��Ư��ê�����������������������������_cL�69)�78/�0/-�.,,�--+�.-+�-,*�-,*�-+*�,+)�,*)�,*)�*))�**(�*)(�*)(�+)(�+)(�,*)�+*)�,+)�-+*�+**�  �                                                                                                                                                                                                                                ss��ii��NN~�??m�;;l�77e�((I�(�!!:�%$R�+��������##!�))'�561�LLE�dfZ�|p���}�������������pw��Xa��BKq�%/e�_�^� \� W� T� V� 
X�X�W�$X�6=b�RXt�WZ_�NSC�{�i������Ͷ��һ�����z|o�GGB�10-�-+*�,+)�,+)�,*)�+))�*)(�**(�*)'�*('�*('�+)(�+*(�+*)�,*)�,++�-,+�-,+�*)(�@                                                                                                                                                                                                                        FFK�hh��tt��\\��HHr�DDp�CCo�<<c�**C�*�""<�&&K�-������))%�9:2�HJ@�TUJ�UWQ�OSW�:@\�$+W�U� 
S� U� X� Z� \� \� ^� ^� ^� ^� ^� [� 
Y� 
W� 	U� F� $� � =�	T�*2b�QZ{���������������������vwj�A@<�,+)�+))�*)(�**(�+)(�*)'�*('�*('�+)(�+*(�,*)�,**�,++�--+�.,+�/-,�,,+�n                                                                                                                                                                                                                8CD@�HIE�KKM�mm������jj��TTw�PPu�PPu�NNr�CC`�**<�,�**D�$$E�$���&'!�,,&�-.*�%'-�0�	2� 9� A� H� 
O� 
T� X� ]� ^� `� a� a� b� b� a� `� `� _� \� D� � 2� O� 
S� 	R� 	P� 	P� 	N�X�;Cq���������������������LLF�*)(�+*(�*)'�*)'�*('�+)(�+*(�*)(�+*)�+**�-,+�.,+�.-,�.--�.-,�.-+��                                                                                                                                                                                                    --+PIIE�IIF�HHE�HHD�JIL�cc�zz��dd��NNx�JJt�IIt�HHt�FFn�::Y�##3�*�--I�*+H� !*���� � #� *� 2� :� B� 	J� 
P� U� Z� ^� a� b� d� d� d� d� d� c� 
_� 4� � I� 
[� 
Z� 
X� 	W� 	V� 	T� 
S� 
Q� 	P� 	O�V�HQx�����������������LLF�+*(�*)'�+)(�+)(�+)(�*)(�*))�,,+�-,+�.,+�.-,�.-,�.-,�.-+�.,+�'%$�			                                                                                                                                                                                            10-eNLH�KJF�IIF�GHD�HHD�HGD�GGI�^^z�uu��^^��HHx�BBs�@@s�@@r�@@q�>>j�11P�,�/�$$J�9�� � � � #� )� 0� 8� ?� G� 	M� 
S� Y� ^� `� b� c� e� i� i� 
_�)� /� S� ]� ^� ]� 
]� 
[� 
Z� 
Y� 
Y� 
W� 
U� 
T� 
R� 	P� 	N�*_�����������������DC>�,+)�+*(�*)(�+**�++*�-,*�.,+�.-,�.-,�.-,�/-,�.-+�.,+�.,+�+*)�

	$                                                                                                                                                                                    10-sONI�NMH�KJF�JJF�HHE�HHD�HGD�HGD�FFG�__{�~~��jj��QQ}�JJw�IIv�IIu�IIt�HHp�BBf�..H�*�7�G�	
5� � � � !� &� -� 3� :� A� 	I� 
P� U� Z� ^� b� g� m� 	U� � 5� U� 
[� _� _� ^� _� ^� ]� 
\� 
[� 
Z� 
Y� 
W� 
U� U� S� 
Q� P�!,c���������������{�;:6�,**�+**�-,+�.,+�.-,�.--�..,�/-,�.,+�.,+�.,+�/-,�/.,�*)(�1                                                                                                                                                                            22.wPOI�POJ�MLH�KJF�KKG�IIE�HHE�HGD�GGD�GGD�FFH�XXv�pp��__��FFy�@@s�??r�??q�??o�??n�==l�77_�%%>�)�;�H�/� � � � #� (� .� 5� =� D� 	K� 
Q� 
W� `� d� 	R�  � <� M� [� 
a� a� a� a� `� `� ^� _� 
^� 
]� 
[� 
Z� 
Z� 
X� W� V� T� 
S�Q�*4h����������Ų�abY�-,*�.-+�/-,�.-,�0/.�0/-�0.,�/-,�0.-�0.-�0.-�/-,�/-,�*('�2                                                                                                                                                                    551oQQK�QQJ�PPJ�NMI�LKG�LKG�IIF�HHE�HHE�HGD�IIE�GGD�QQO�vx������mm��TT�OOx�OOx�OOw�OOv�OOv�OOv�LLr�AA_�((;�)�%&D�E�(� � �  � $� )� 0� 7� ?� F� P� 
X� I� � 9� L� \� 
d� 
d� 
c� c� c� b� b� b� `� _� _� 
]� ]� 
\� [� Z� Z� 
Y� W� V� U�W�HR|�������������652�.--�..-�0/.�0/-�0.-�0.-�0.-�0.-�/-,�/-,�/-,�/-,�*)(�


'                                                                                                                                                            551bRRM�RRL�RRK�PPJ�NNI�MLH�MLH�JJF�JJF�IJE�HGD�JIF�`aY���z�mp`�9;[�wx��oo��VV��NNw�MMw�MMv�LLv�LLv�LLv�LLv�JJq�>>[�$$2�,�%&E�>�&� � �  � %� *� 1� :� D� 8�  � 6� E� W� `� b� d� f� e� e� d� d� d� d� a� `� _� ^� ^� ]� ]� ]� \� [� [� Z� X� V�[�������������PPJ�1/.�0/-�0.-�0.-�0.-�/-,�/-,�/-,�/-,�/-,�/-,�/.,�-+*�
		                                                                                                                                                    22/NTTO�TTO�QRM�QRK�QQJ�NNI�OMI�NMH�JJF�JKF�IJE�KJG�prg�������{�/28�1�+/|�wx��qq��WW��PPy�PPy�QQx�QQy�QQy�QQz�RRy�SSx�OOo�<<R�$$/�&&4�"#F�8�#� � � "� '� -� (�  �  )� 9� L� 	V� 
Z� ^� a� c� e� f� f� e� e� e� e� c� a� `� `� _� _� ^� ^� ^� ]� \� [� Z� Z� Y�OY����������kka�0/-�0.-�0.-�0.-�/-,�/-,�/-,�/-,�/-,�/.,�0.-�0.-�*('�

	                                                                                                                                            2SSN�UUP�TTO�RSN�QRL�QRK�OOJ�POJ�NMI�LKG�KLG�PQL�y{m�����x}w�#P�� E�	_�$+��vx����bb��YY~�YY}�YY}�YY}�ZZ}�ZZ}�[[|�\\{�^^x�XXl�@@K�$$,�&&7�"#G�
4�  � � � �  � � +� 8� C� K� R� 	W� 
\� _� a� d� e� f� f� e� e� e� e� c� a� `� a� `� `� ^� ^� _� _� ^� ]� \� Z�&3k�����������u�20/�0.-�/-,�/-,�/-,�/-,�/-,�/.,�0.-�0.-�0.-�0.,�$#!�
                                                                                                                                    PQL�UVQ�UVQ�UUP�STO�RRM�QRK�QQK�PPK�ONI�LKG�VVP���x�����osv�M� E� � V� e�
l�#*��|~��xx��\\��SS{�SSz�SSy�SSx�RRx�RRw�SSv�TTs�UUq�TTl�HH\�--;�&�"#:�E�.� �  �  � � '� 0� 7� >� E� L� S� 	Y� \� _� b� d� e� f� e� e� f� f� e� d� c� b� a� `� `� `� `� _� ^� _� ]� [�a�������������32/�/-,�/-,�/-,�/-,�/.,�0.-�0.-�0.-�0.,�0/-�0.-�~                                                                                                                                    PPL�VWR�UWR�UVQ�UUP�TUP�SSN�QRL�RRK�RRM�ONJ�WWQ���������W[g�L� M� H� #� d� 
j� m� 
o�"��xz������ff��XX}�XXz�WWy�WWx�WWw�WWv�YYu�ZZs�[[r�\\r�[[p�OO`�00:�)�))C�8�$�  � �  � %� +� 1� 8� ?� G� M� 	T� 	Y� ]� `� c� d� f� f� e� e� f� f� e� d� c� c� c� b� b� b� a� `� _� ^� \� [�v~����������642�/-,�/-,�/.,�0.-�0.-�0.-�0.-�0.-�0/.�0/.�/..�P                                                                                                                            ==:pXXS�WXR�VWR�UVQ�UVQ�UUP�TTO�SSN�RRK�RSN�[\U��������SWh�
G� T� R� A�1� s� 	o� 
n� o� p�$��sv������kk��^^}�__{�__z�``z�``y�aax�aaw�aav�aav�aav�__v�[[q�FFW�((2�$$0�$$A�:�&� � � !� &� ,� 2� :� A� H� O� 	U� 
Z� ^� a� c� e� f� e� e� e� f� e� d� d� d� c� b� b� b� a� `� _� ^� \�Z�gp����������420�/.,�0.-�0.-�0.-�0.-�0/-�1/.�0/.�/..�/.-�-++�                                                                                                                    %%#4XXS�XXT�XXS�VWR�UWR�UVQ�UUP�TUP�TTO�SSN�]]W���������RWj�
I� P� `� S� >�9� {� 
r� 
o� 
p� 
p� 
p���pr������pp��aa{�a`y�aay�aax�aaw�bbw�bbw�bbw�bbx�bby�bby�bbx�[[o�EER�''.�$%3�$%F�7� $� � � "� '� -� 4� ;� B� J� Q� 	W� 
[� _� a� c� e� e� e� e� e� e� d� d� d� c� b� b� b� a� `� _� ^� \�Z�cm����������310�0.-�0.-�0.,�0/-�0/.�0/.�.--�/--�/--�0.-�&&$�                                                                                                                TTO�YZU�YYT�XXS�WXS�VWR�UVQ�UVQ�UUP�TTO�YYS���������Y^m�
K� R� [� 	g� R�  7�H� �� t� 
p� 
p� 
p� 
p� 
q���wy����������sr��qq��qp��pp��oo��nn�ll~�jj~�hh~�gf}�ee|�ddz�bbw�XXj�::F�!!)�#$7�F�0� !� � � $� )� /� 6� =� D� L� R� 	X� [� _� b� d� e� d� e� e� e� d� d� d� c� b� b� b� a� `� _� ^� \�Z�gp���������1/.�0.,�1/-�0/.�//.�.--�/--�0.-�0.-�/.-�.--�TSSl                                                                                                            GGB|[[U�Z[U�YZU�XYT�XXS�WXR�VWR�UVQ�UUP�VVQ���|�����ehq�	J� U� ]� d� i� O� 1�V� �� 
u� 
r� 
r� 
r� 
r� 
r� 	r�{�oq������~~��kk�ii}�ji}�ji}�jj}�ji~�jj�jj��jj�kk�ll�ll~�mm~�jj|�\\k�77A�##*�++B�D�0�  � �  � $� )� 0� 7� >� E� M� 	S� 
X� \� `� b� d� d� d� e� e� d� d� d� d� b� b� b� a� `� _� ^� \� X�y�������vwj�10.�0/.�0/.�/..�/--�/.,�/-,�-,+�-,,�.,,�-+*�*                                                                                                    !!,[\T�[\U�Z[U�ZZU�YYT�XXS�WXS�VWR�UVQ�VWQ�|s�����w}�
N� R� ^� e� 	k� j�  G� )� 	c� �� 
u� 
r� 
r� 
r� 
r� 
r� 
r� 	r�}�uw����������uu��sr��rq��pp��oo��mm��kk��kj�ji~�hh|�gg{�ffz�ddz�ddy�``t�NN_�//9�$$.�$%@�@�*� � � !� %� +� 2� 8� @� G� N� 	T� Y� ]� `� b� c� d� d� e� d� d� d� d� b� b� b� a� `� _� ]� \�_���������^^V�0/.�0/.�0.-�0.-�/.,�-,+�-,,�.,,�.,+�/.,�%$"�                                                                                                    QQJ�^^V�[\U�[[U�ZZU�YZT�YYT�XXS�WXR�VWR�nof���������P� O� [� 	e� 	k� 
o� l�  E� )� 	`� �� 	s� 
r� 
r� 
s� 
s� 
s� 
s� 
s� 	s�}�cg����������kl��jj�jj�kk�kk�ll�ml�mm��nn��nn��mm��nn��nn��nn��ll�eew�LL[�++4�$$0�#$E�9�$� � � "� '� ,� 3� :� A� I� 	O� 
U� Y� ^� a� f� i� k� m� l� l� l� k� h� g� e� a� `� _� _� \�#f���������>>;�1//�0.-�/.-�-,,�-,,�.,+�.,+�-,*�.,+�.,+�O                                                                                            672F^_W�^^W�]]V�[\U�[[U�ZZU�YZT�XXS�XXS�bc\���������&,V� L� Y� c� 	j� 
n� 
p� n�  I� +�
k� �� 	s� 
t� 
t� 
t� 
t� 
t� 
t� 
t� 
t� 	t�|�dg����������qq��oo��pp��pp��pp��pp��qq��qq��rr��rr��rr��ss��tt��tt��tt��ss��kk{�MMX�((/�++9�)*G�
1�  � � � #� (� .� 4� <� G� U� d� q� z� �� �� �� �� �� ��  �� !�� �� �� �� �� �� z� n� e� ]�'5o���������320�0/.�.--�.,,�.,,�-,*�-+*�-,*�.,+�.,+�*('�                                                                                        WXQ�_`W�^_W�^^V�]]V�[\U�Z[U�ZZU�YYT�[[V���������MQh� H� V� a� 	i� 
n� 
q� 
r� m� E� '�l� �� 
t� 
t� 
t� 
t� 
t� 
t� 
t� 
t� 
t� 
t� 	t�y�bf����������zz��xx��yx��zz��{|��}|��}}��~�������������������������������������ts~�KKQ�**-�12?�!"B�+� � �  � '� 0� <� J� U� ^� a� e� U� N� M� I� 
F� I� 
F� N� \� g� t� �� �� !�� !�� �� ~� l�O[������y{p�.--�.,,�.,+�-,*�-,*�.,+�-+*�-+*�-,*�--*�m                                                                                    783\`aX�_`W�_`W�^^W�^^V�\]U�[[U�Z[U�YZU�xzo�����{��I� R� ^� 	g� 	n� 
q� 
s� 
s� n� G� /� m� �� 
v� 
u� 
u� 
u� 
u� v� v� 
u� 
u� 
u� 
u� 
u�
|�^b������������������������������������������������������������������������}}��ww��bbl�;;B�''-�()<�<�+� &� (� +� (� � �  �  �  �  �  �  �  �  �  �  �  �  �  �  � �  �  �2� I� \� d� c���������LKF�.-+�-,*�-,*�.,+�.,+�,**�+**�,**�-+*�))'�???                                                                            YZR�`bY�`aX�_`W�^_W�^^W�]]V�[\U�[[U�bc[���������%R� L� Z� 	e� 	l� 
p� 
s� 
t� 
t� 	q�  K� .�	k� �� y� v� v� v� v� v� v� v� v� v� v� v� 
v�{�UY��������������}}��~��������������������������������������������������������������~��cck�99>�**2�,.E�7��  �  �  �  �  �  �  �  � "� (� ,� 0� 1� 1� .� *�  $�   �  � � �  �  �  �  � �2���������10-�-,*�.,+�.,+�-,*�,**�,**�-+*�-,*�,+*�RQQr                                                                            ??<Rbc[�abY�`aX�`aX�_`W�^_W�^^V�]]V�[\U��������RXl� G� U� b� 	j� 
p� 
s� 
t� 
u� v� q� J� ,�]� �� {� v� v� v� v� v� v� v� v� v� v� v� v� 
v�t�ST������������������������������������������������������������������������������������������eek�558�//6�//A�%�  �  �  � � !� *� 1� 8� ?� G� 	M� 
Q� V� Z� [� Z� 	V� P� I� >� 4� -� /� 3� :� 2�6>I��Ɣ�+/#��&$$�-,*�-+*�-+*�-,*�,,*�,+*�,++�/.-����                                                                        ��}�ijc�acZ�abY�`aX�_aX�_`W�^_W�^^V�npf���������F� O� ]� 	h� 
n� 
r� 	t� 
u� v� v� 
t� L� 1�P� �� 	}� x� x� x� x� x� x� x� x� x� x� w� 	w� 	w� f�V�KJy�����������������������������������������������������������������������������������������||��VV]�--1�00;�()D�
-� � � � "� '� -� 3� ;� B� 	I� 
N� T� Y� \� ^� `� b� a� a� \� X� 	Q� 	N� 
M�R�������������&&#�++)�,+*�-++�.,+�.,+�feca                                                                    8����tun�ac\�acZ�abY�`aX�_aX�_`W�``Y���������6;\� H� X� d� 	l� 	q� t� 	u� 
v� 
v� 	w� 	w� X� 8�K� �� 
�� x� x� x� x� x� x� x� x� x� x� x� x� v� `� F�^�HN����������������������������������������������������������������������������������������������xw��MMS�--2�22A�"#A�	)� � � � #� (� .� 5� <� C� 	J� 
P� V� Z� ]� `� a� `� ^� \� Y� X� V� U�3=n�����uvk�*)(����� �+*)�.-+�.-+�)(&����	                                                                �������~�de^�ac[�abZ�`bY�`aX�_`W�suj���������C� P� ^� i� p� t� v� 	w� w� x� x� x� \� :�>� �� �� x� x� x� x� x� x� x� x� x� x� x� w� t�  Z� 9� z���CG����������������������������������������������������������������������������������������������}}��jjt�??F�)*0�-.@�<�$� � �  � $� )� /� 7� >� 	E� 
M� T� Y� ]� `� a� ^� [� 
X� 
T� 	R� 
R�R������ͻ�553�,++�+**�'%$���
		��*)(�.,+����9                                                            
�__X�����lmf�bc\�ac[�abZ�abY�acZ���������16Z� H� X� d� m� s� u� w� x� x� x� x� x� _� 8� +� �� �� y� z� z� z� z� z� z� y� y� y� x� x� n�  S� 5� 
�� 	}�	x�:?������������������������������������������������������������������������������������������������������rrx�>>A�--4�12I�7�"� � �  � %� +� 2� 9� B� 	K� S� Y� ^� a� a� `� ]� Y� 	T� 
Q� 
P�"-c�����rtk�-,,�-++�.,+�--*�+*(��	���-,+�                                                            "#d�++'������y�bd]�ac\�ac[�acZ�prg���������C� O� ^� i� p� u� v� w� x� x� x� y� y� l� >� &� �� �� {� z� z� z� y� y� y� x� x� w� v� u� f�  I� 9� �� u� o� s�5;����������������������������������������������������������������������������������������������������������ggn�447�33<�./I�1�� � � !� '� .� 7� B� 
M� U� [� `� a� a� `� _� Z� W� T� O������ĳ�542�.-+�.-+�.-+�/-,�/-,�.,+�! ������                                                        >@9� ��uum�����kke�bd]�bc\�ac[���������>B_� F� V� d� m� s� w� x� x� y� y� z� z� z� r� E� +�}� �� 	~� z� {� z� z� y� x� w� u� t� r� p� `�  H�G� z� k� i� k�o�38��������������������������������������������������������������������������������������������������������������YY_�237�44@�'(<�
 � � �  � &� /� :� 	G� 
R� Y� ^� a� b� a� `� ^� Z� V� R�3=m�����cc[�/-+�/-,�/-,�/-,�/.,�//,�/.,�..+�! �~~~U                                                     ]^V�+,&��>?9�����|}u�de^�bd]�gh`���������F� M� ]� i� q� u� x� y� y� z� z� z� z� z� y�V� :�U� �� �� {� {� z� y� w� u� s� p� n� k� g� T� ;�A� 
j� ]� \� `� f�m�-2������������������������������������������������������������������������������������������������������������������VVZ�224�56<�#%4�� �  � )� 4� B� 
O� X� ^� a� b� b� a� `� ]� Y� T�T���������20-�0-,�/-,�/.,�/.,�//,�//,�00-�//-�@??�                                                    HHC^hi`�?@8����������nnf�ce]���x�����]br� B� R� b� m� s� w� x� z� z� z� z� z� {� {� {� h� B� :� �� �� |� z� y� v� r� n� j� f� b� ^� Y� D�  1�;� 	[� M� M� R� Z� b� k�&+����������������������������������������������������������������������������������������������������������������������LLL�445�;<D�$� � %� 1� ?� 	L� W� ]� a� c� c� b� a� `� ]� X� S�Zc������CB>�//,�//,�//,�//,�00-�//-�/.-�/.-�1/.彼�                                                ^_X�klc�XYQ�%&"��682�����w�gh_���������!%N� H� Y� g� p� u� x� y� z� z� {� |� |� |� |� |� o� H� .� �� �� � z� w� s� l� e� ^� X� S� M� G�  6� &�-� F� ;� =� C� L� V� `� i�!'����������������������������������������������������������������������������������������������������������������������{{{�EEE�')9� � #� /� >� 	K� V� ^� a� b� c� b� b� b� _� \� V�%_�������s�0/-�00-�/0-�//-�/.-�/..�0..�1/.�0/-����K                                            ikb�lmd�hi`�AB:�  �
���������|~t���������@� N� ]� k� r� w� y� z� {� {� |� |� |� |� |� |� w� K� 5�g� �� 	�� y� t� l� c� Y� P� H� B� =�:�1�)�"� 5� .� /� 6� ?� J� U� _� f� y���������������������������������������������������������������������������������������������������������������������hhh�./=� � #� .� =� 	J� V� ^� a� b� c� c� b� b� a� _� [� V���������11.�00.�0//�0..�1/.�1/.�10.�10.�10.�YXW�                                            9:48lne�lme�kmd�\]T�*+$��-.)�������������U[n� B� S� b� n� u� x� z� {� |� |� |� |� |� }� }� ~� }�a� ;�A� �� �� x� o� e� X� L� B�	=�C�,.N�DFZ�NNW�FEJ�**<�.� &� %� *� 3� =� H� U� X� R� "o�����������������������������������������������������������������������������������������������������������������rrs�;<G� � "� -� <� 	K� U� ^� b� b� c� d� b� b� b� `� ]� Y�R]������>>:�200�110�10/�10.�10.�10.�10.�1/.�754�                                            FGAiopf�mof�lme�ijc�HJA�"#��sul��̿��ȵ�"L� G� X� f� q� w� y� {� |� |� |� |� }� ~� ~� ~� ~� ~� s� I� =�z� �� }� l�a�X�$'[�>@^�RSa�WW\�aac�uuu�����bbc�::<�/2H�#� � #� )� 1� <� F� J� D� f�������������������������������������������������������������������������������������������������������������������DEO�� "� -� ;� 	J� U� ^� b� c� c� d� c� b� b� a� ^� [�%d�����tvl�431�330�320�210�200�10/�10/�10.�..,����                                         \^U�oqg�oqf�npf�lne�bd[�12+��8:2������ƽ� =� L� \� j� s� x� z� {� |� |� }� ~� ~� ~� ~� ~� � � ~� c� >�F���#��8;|�MOr�XYf�]^`�iii�������������������������nnn�88:�01C�!� � "� (� 0� 3�  5� B� `� g�}�������������������������������������������������������������������������������������������������������������JKU�� "� -� ;� 	J� V� ^� b� d� d� d� c� b� b� a� _� \� W���������542�542�432�321�321�320�320�21/�21/����?                                    

mof�orh�oqg�oqf�opf�lme�LNF�""�&(��������� O� P� `� m� u� y� {� |� }� ~� ~� ~� ~� ~� � �� �� �� �� u� A�;�UZ��egx�eeh�xxz�����������������������������������������vvv�??A�77E�	"� � "� '�  '�  &� C� S� ]� h�|���������������������������������������������������������������������������������������������������������KLV�� "� -� ;� 	J� V� ^� b� d� d� d� d� c� b� b� _� ]� X�u������976�643�643�543�542�542�532�431�431�rrqs                                    rsi�qsi�prh�org�oqg�opf�hi_�792�:=.�lsU�KRx� 
i� Z� c� o� v� {� |� }� ~� ~� ~� ~� � �� �� �� �� 	�� �� � X�@�����������������������������������������������������������������BBC�>>J�	
$� �   �  �  "� >� F� Q� \� f�|�����������������������������������������������������������������������������������������������������QR[�� !� -� ;� 	I� V� ^� b� d� e� d� d� c� b� b� `� ^� Z�@Ky�����QQK�976�875�764�764�764�663�764�653�_^]�                                    :;6-suk�suj�rtj�psh�org�oqg�opf�[]T�^dP�goO�#� w� x� k� r� y� {� }� ~� ~� ~� � � �� �� �� �� �� �� �� �� s�O���������������������������������������������������������������������AAA�@AL�%�  �  �  !� 4� 9� D� P� ]� l���������������������������������������������������������������������������������������������������ST\�� !� ,� ;� 	I� V� ^� c� d� e� d� d� d� b� b� `� ^� [�a�����mnf�:97�:97�:97�986�875�876�876�876�210�                                    >?8Wuwk�svk�suk�stj�qsi�prh�oqg�prh�����`iU�	� H� �� �� t� y� |� }� ~� ~� �� �� �� �� �� �� �� �� �� �� �� ��q�������������������������������������������������������������������������BBB�?@J�%�  �  � )� -� 7� D� X� 
j� ]�	E�vu������������������������������������������������������������������������������������������WXa�	#� "� ,� ;� J� V� ^� d� d� e� e� d� d� c� b� `� _� [� V�������x�;:8�;:8�:98�:98�;98�:98�:87�:87�653����                                KLE�uxl�uwk�tvk�suk�stj�rtj�psh�uxm�����mre�
�  � u� �� 
�� z� }� ~� � �� �� �� �� �� �� �� �� �� �� �� �� ��"&������������������������������������������������������������������������������GGH�??F�&� � #� %� .� 9� @� <�  =�  E�[�ln��������������������������������������������������������������������������������������XZc�.� -� 0� ;� J� 
V� ^� d� e� e� f� d� d� d� b� a� _� ]� X���������:98�:98�;99�<:9�<:9�<:9�<;9�;:8�:97����                                psi�vyn�vxm�vxl�twk�tvk�suk�rtj�|~r��Ƴ�y}�  �  �*� �� �� 	�� }� � �� �� �� �� �� �� �� �� �� �� �� �� �� ��'+����������������������������������������������������������������������������������QQQ�GGL�0�  �  � %� *�  %�  3�  <� R� c�w�il����������������������������������������������������������������������������������YY\�	!� 
5� B� 	F� K� 
V� ^� d� f� e� f� e� d� d� c� a� `� ]� Y�nw������<:9�<:9�<:9�<;9�<;9�<;9�<;9�<;9�<;9����*                                suk�wzo�vyn�vyn�vxm�uxk�tvk�suk���{��ɶ�imw� )� � �A� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��(,��������������������������������������������������������������������������������������RRR�FFL�4� �  �  �  $� 0� >� L� [� k�t�nq������������������������������������������������������������������������������ZZ\�� � ?� ]� ^� 
Z� ^� d� f� e� f� e� d� d� c� b� `� ^� Y�PYw�����@?<�<;9�<;9�<;9�<;9�<;9�<;9�=;:�=;:����F                                vxn�y{p�xzo�wzo�vyn�vxn�vxl�uwk������θ�SVj� <� 0� � �h� �� �� 	�� �� �� �� �� �� �� �� �� �� �� �� �� �� ��*.������������������������������������������������������������������������������������������\\\�IJO�$%9��  �  #� +� 5� C� S� _� e�	j�����������������������������������������������������������������������������[\_��  �  � C� u� {� i� d� f� f� f� f� d� d� d� b� a� ^� Y�4?j���~�DB@�<;9�=;:�=;:�=;:�=;:�=<:�=<:�=<:����b                                x{p�z|q�y|q�y{p�xzo�wzo�vyn�vxm������͹�BEa� ?� K� 5� "� �x� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��+/����������������������������������������������������������������������������������������������hhh�HHL�**=�#� '� +� 9� G� Q� [� ^�i�����������������������������������������������������������������������������[[b��  �  �  � 9� �� �� r� f� f� f� f� e� d� d� b� a� _� Z�!-e���v�GFB�=;:�=;:�=<:�=<:�=<:�=<:�=<:�=<:����v                                {}r�{}r�z}r�z|q�z|q�y{p�wzo�wyo������ι�5:[� ?� R� Y� 9� &� $��� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��7;��������������������������������������������������������������������������������������������������ppp�EEI�-/I�-� (� ,� 9� @� Q�$m�z}������������������������������������������������������������������������������Z[a�� �  �  �  � 1� �� �� x� g� f� f� e� d� d� c� b� _� [� a�{}n�HHC�=<:�=<:�=<:�=<:�=<:�==:�==:�>=;�����                                }t�}t�}s�{~s�{}r�z}r�z|q�yzp������л�.2X� @� S� d� c� ;� '� *��� �� �� �� �� �� �� �� �� �� �� �� �� �� ��RU������������������������������������������������������������������������������������������������������tss�==@�//F��  �   �!�,,K�������������������������������������������������������������������������������������^^d� �  � (� "� �  �(� �� �� y� g� f� f� d� d� c� b� _� [�^�wxj�IIC�=<:�==:�==:�>=;�>=;�>=;�>=;�>=;�����                                �u��u�~�u�}�u�|t�|~s�{}r�z}r������ѽ�,0S� @� S� d� r� n� >� (� "��� �� �� �� �� �� �� �� �� �� �� �� �� ��Z]����������������������������������������������������������������������������������������������������������{|{�EEH�77P�,�)�@?U�����������������������������������������������������������������������������������������^_e� �  � *� 6� 1� � � #� �� �� z� f� f� d� d� d� b� _� [�W�rtf�IID�>=;�>=;�>=;�>=;�>=;�?=<�?><�?><�����                                �w��v��v��u�~�u�}�u�|t�|~s������ҿ�-0R� ?� S� d� r� z� n� B� ,� (�z� �� �� �� �� �� �� �� �� �� �� ����nq������������������������������������������������������������������������������������������������������������������MMQ�KLb�NNc���������������������������������������������������������������������������������������������_`d�$�  � )� 8� F� ?�  �  � +� �� �� v� f� e� d� c� b� _� [�U�qsf�IHE�>=;�?=<�?><�?><�?><�??<�>?<�>?<�����                                ��x���x���w��v��v��v�~�u�~�u���������-0U� ?� S� d� r� z� ~� s� H� .� '�l� �� �� �� �� �� �� �� �� �� ����y{��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������hhk�,� � )� 7� G� S� H�  !�  � +� �� �� s� e� d� c� a� _� [�V�rte�IID�?><�??<�>?<�>?<�>?<�>?<�>><�>><�����                                ��x炅y���y���x���x���w��v��v���������25Z� >� Q� c� r� z� � �� x� O� -� +�K� �� �� �� �� �� �� �� �� ����yz��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������ssv�-� � )� 7� F� 	T� 	]� I�   � �0� �� �� l� d� c� a� _� Z�Y�rse�HIC�>?<�>?<�>><�>><�>><�>><�>><�>>=�����                                ��y҄�{���z���z���y���y���x���w���������=B]� <� P� b� p� z� � �� �� �� _� 8� +� 1��� �� �� �� �� �� �� ����{|��������������������������������������������������������������������������������������cc��
L�[�������������������������������������������������������������������������������������������������������������������������vvx�-� � )� 6� F� 	T� 	]� 	a� G� "� �	J� "�� �� i� c� b� _� Z�Z�qrd�EFB�>><�>>=�>>=�>>=�>>=�>>=�>>>�>>>����q                                ��y���|���{���{���{���z���z���y���������KOf� ;� M� `� p� y� � �� �� �� ��k� B�	 1� .�T� �� �� �� 	�� �� ����������������������������������������������������������������������������������������;;Z�8�  F�  G�d���������������������������������������������������������������������������������������������������������������������qqs�-� � )� 6� E� T� 	]� d� 	c� ?� � � Z� "�� }� d� b� _� Z�$X�opc�CCA�>>=�>>>�>>>�>>>�???�???�???�?>>����[                                ��y���~���}���|���|���|���{���{���������aet� 9� K� ^� n� y� � �� �� �� �� ��z� W�	 8�	 1� ;�o��� �� �� 	����������������������������������������������������������������������������������6�  '�  3� D�  E� O�	��in��������������������������������������������������������������������������������������������������������������ppr�!4� � )� 6� E� T� 	]� d� g� 
a� 8� � � ~� !�� t� b� _� Y�&.W�nob�BBA�???�?>>�?>>�?>>�?>>�?>>�?>>�?>>����?                                ��z���������~���~���~���}���|���������|��� 7� I� \� l� x� � �� �� �� �� �� �� ��o� H�
 1�	 .�?�
{��� ����������������������������������������������������������������������������fft�		�  �  %� 0� <�  <� F� s�x�NR����������������������������������������������������������������������������������������������������������cce�"%8�  � *� 8� F� 	T� 	^� d� g� g� 	[� )� �#� �� �� j� ^� X�8>[�lm`�?>>�?>>�?>>�?>>�?>>�?>>�?>>�?>>�?>>����%                                LMG{������������������������~�������������8� F� Y� j� w� � �� �� �� �� �� �� �� �� �� h�	 F�
 6�
 3�
 0�[���������������������������������������������������������������������������ZZg��  �  #� )� 2�  4� <� f� k�p�9<������������������������������������������������������������������������������������������������������tuv�%(=� $� -� :� H� 	U� 
_� d� g� h� h� R�  #�  �5� !�� � _� V�EMc�ceZ�?>>�@>>�@>>�@>>�A?>�A?>�A?>�A?>�?=<����                                KMEJ���������������������������������λ�����:� B� U� g� t� }� �� �� �� �� �� �� �� �� �� �� �� l�	 L� =�
 <�@�������������������������������������������������������������������������KKN�55G�"�  � $�  (�  *� 6� W� ^� f�o�)-��������������������������������������������������������������������������������������������������rrt�%(@� )� 3� ?� L� 	X� 
a� e� g� h� h� e� B� � � q� �� n� T�X\e�\[U�A?>�A?>�A?>�A?>�A?>�A?>�A?>�A?>�<;:����                                IKD'���������������������������������ų�����B� ?� Q� d� r� |� �� �� �� �� �� �� �� �� �� �� �� �� ��x� b�\�������������������������������������������������������������������������||~�<<?�33E�"�  �  !�  !� -� E� N� Z� e� n�����������������������������������������������������������������������������������������������uuw�%)G� 2� ;� G� R� 	[� 
c� f� h� h� h� h� 
]� .�  � � �� �� Z�qsj�TSN�A?>�A?>�A?>�A?>�A?>�A?>�A@>�A@>�::7�                                    ���쐓����������������������������������69W� ;� L� `� p� {� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��������������������������������������������������������������������������������yy{�<<?�44G�"�  �  � *� 7� ?� M� Y� d� m�`�����������������������������������������������������������������������������������������pps�&*Q� >� F� P� 	X� 
_� 
e� g� h� i� h� h� g� Q�  !�  � :� ��l�xyk�JIF�A@>�A@>�A@>�A@>�A@>�A@>�A@>�A@>�vvt�                                        ����������������������������������������jo{� 7� H� [� l� y� � �� �� �� �� �� �� �� �� �� �� �� �� �� ������������������������������������������������������������������������������������ttw�;<>�23E��  �  &� +� 3� ?� K� X� c� P�D�``����������������������������������������������������������������������������������ttw�%+[� L� S� 	Z� 
_� 
d� h� h� i� j� h� h� g� c� >�  �  � o�=M��}�q�BB?�AA>�AA>�AA>�BA>�BA>�AA>�AA>�AA>�zzxa                                        qti����������������������������������������� 4� C� V� h� v� � �� �� �� �� �� �� �� �� �� �� �� �� �� ����������������������������������������������������������������������������������������wwy�<<?�44D� �   �  #� *� 3� >� J� X�P� =�K�OY����������������������������������������������������������������������������������")h� 	Y� 	]� 
b� 
e� g� i� i� i� j� h� h� g� f� 	X�  $�  � -�pz����~�DC@�BA?�BA?�BA?�BA?�BA?�BA?�BA?�A@>����6                                        _bXZ����������������������������������������6� >� P� c� s� |� �� �� �� �� �� �� �� �� �� �� �� �� �� ��������������������������������������������������������������������������������������������nnr�335�11B�$�  � #� )� 3� =� K� L� =�H���>E��������������������������������������������������������������������������4;|�c� 
c� 
d� g� h� i� j� j� j� j� h� h� g� f� b� =�  �  �z|s�����NMK�BA?�BA?�BA?�BA?�BA?�BA?�BA?�?><����                                        BC=1����������������������������������������;>Y� 9� J� ]� n� z� �� �� �� �� �� �� �� �� �� �� �� �� �� ��&(����������������������������������������������������������������������������������������������ttw�547�44D�#� � #� )� 2� >� B� 9� 7� ��
�%+����������������������������������������������������������]b�� &r�f� e� 
h� i� i� k� k� j� k� j� j� j� h� h� g� f� c� 
W� '��56,�rqn�a`]�EDA�CB@�CB@�CB@�CB@�CB@�CB@�QQN�                                             !
���Ϛ��������������������������������������� 4� D� V� h� u� � �� �� �� �� �� �� �� �� �� �� �� �� ��68��������������������������������������������������������������������������������������������������{{~�77:�67F�#� � #� (� 2�  5� -� &� 
t� s� q�~���������������������������������������������8>q��� o� h� 	k� 	j� l� m� l� m� l� k� l� j� j� j� h� h� g� e� a� \� :���>>;�mmi�NNJ�CC@�CC@�CC@�CC@�CC@�CC?�ooms                                                ��y�����������������������������������������:� >� O� b� q� |� �� �� �� �� �� �� �� �� �� �� �� �� ��<=������������������������������������������������������������������������������������������������������mms�336�00A�	#� � "� (�  ,�  (� )� 	g� h� i� p�|�z}��������������������������]b��  [�-� (� �� � 	m� 	o� 	n� n� n� m� n� m� l� l� j� j� j� h� g� f� d� `� [�M�145���nlh�][W�EDA�DC@�DC@�DC@�DC@�CB?����:                                                ^aXQ���������������������������������ŵ�����EGa� 8� H� [� l� x� �� �� �� �� �� �� �� �� �� �� �� ����MM����������������������������������������������������������������������������������������������������������nns�003�01@�	
$� � "�  $�   � � U� Z� _� h� o�	y�cf��������������@E��w�n� \� 5� !� �� �� 	q� 	q� 	o� o� o� n� n� m� l� l� j� j� j� h� g� e� c� _� X�!U�Z\P���NMK�kjf�JIG�DCA�DCA�DCA�DCA�HHF�                                                    8:5���覩�������������������������������������� 4� A� S� e� t� ~� �� �� �� �� �� �� �� �� ��������Z[��������������������������������������������������������������������������������������������������������������pqs�225�77E�	#� �  �  � � D� I� S� ^� h� o�u�,2�� &��x� u� s� 
r� j� >� '� �� �� 
t� 	q� 
p� p� o� n� n� l� l� l� j� j� j� h� f� e� b� \� T�FLc�jk_���'&%�ttr�\[Y�EDB�EDB�EDB�EDB�RRO�                                                        ��������������������������������������������$&J� :� J� ]� m� y� �� �� �� �� �� �� ��������$&��*,��np������������������������������������������������������������������������������������������������������������������iio�336�55C�%�  �  �  � 7� ;� E� Q� ]� g� m� r� u� u� v� v� 
u� q�  M� :�\� �� y� 
r� 
p� p� o� n� n� l� l� l� j� j� j� h� f� d� `� Y�
R�svp�Z[S�**'��		�UVR�qqm�LLH�EEB�EEB�EEB����<                                                        QTJI�µ����������ʼ�������������������������wz��4� B� T� e� t� ~� �� �� �� �� ��	����&'��03��9=��@C��vx����������������������������������������������������������������������������������������������������������������������ggl�225�44A�#�  � � ,� 0� 9� D� Q� \� e� m� r� t� v� v� 
u� 
t� R� 6�?� �� � 
r� 
p� p� o� n� n� l� l� l� j� j� j� h� f� b� ]� T�19]�}~o�KJF�875����rrm�ZYU�FEB�FEB�BB?�                                                                ;@/�ekX������������������ǹ�����������������A� ;� K� ]� m� y� �� �� �� ������)+��8;��EH��PR��WZ��df��������������������������������������������������������������������������������������������������������������������������hhp�226�22?�� � #� '� .� 8� D� Q� [� e� l� p� t� u� 
u� 
u� [� 8�-� �� �� 
q� 
p� p� o� n� n� l� l� l� j� j� i� g� d� `� Y� Q�nrp�ef\�GFC�DC@�! ���^][�ihd�IHE�FEC�ZYW�                                                                >C4�@F2�;A.�MR>���w��ʻ���������������������ps�� 4� B� S� e� s� ~� �� ������(*��9<��JM��Y\��fh��nq��tv��uw�����������������������������������������������������������������������������������~~��~~��}}��}}��~~��~~��~~��~��}~��bbm�//4�22>�'� � !� &� .� 8� D� O� [� d� k� p� 	r� 
t� 
u� b� :�'� �� �� 
q� 
p� p� n� n� n� l� l� l� j� i� h� f� b� ]� T�)2[���s�MMI�GFD�GFD�653��
		�765�rqn�SRO�EDC����&                                                                =?6"biT�SZD�IO<�CJ6�6=*�]cO������ƹ�������������!^� Q� Z� f� p� z� �� ����"%��59��IL��]_��np��{~������������������������������������������zz��vv��uu��uu��uu��vv��vv��ww��xx��yy��zz��{{��||��}}��~~������������������������������������eep�005�55E�'� �  � %� -� 7� B� N� Z� c� k� 	n� 
r� 	s� e� >�1� �� �� 
r� 
p� p� n� n� m� l� l� l� j� h� g� d� _� W�P�nqo�gh^�GGD�GGD�GGD�CC@�""���sso�^^[�ffd�                                                                        ��������y�k�cjS�W^F�RXB�FM8�DK4�]dM������������� Y� s� �� �� �� ����#-��:B��PV��fk��{~����������������������������������������������������������������������������������~~��}}��{{��zz��xx��ww��uu��tt��ss��ss��rr��rr��rr��ss��tt��uu��tu��]]j�--2�12?�)� � � %� ,� 6� B� M� Y� c� 	i� 
n� 	q� j�  >� $� {� �� 
r� 
p� p� n� n� m� l� l� k� j� h� f� a� [� Q�6>]��s�LLG�HHD�HHD�HHD�HHD�441���VVS�jje����F                                                                        VYQ=������������������p�jrZ�`hN�W_F�W`G��Ŧ�����#� � 7�d��� ��3��BW��fv����������������������������������������������xx��?;��( ��KE����������������������~~��~~��������������������������������������������������������������������������~��ffp�004�01>�+� �  � $� ,� 6� A� M� X� a� 	i� 	m� i�  ?� '�l� �� 
q� p� o� n� n� m� l� l� k� i� g� c� ^� U�R�uxr�cc[�IIE�IIE�IHE�IIE�IIE�@@=���.-+�xxr����	                                                                            �������������������������������}�k���x���������  �  � 
� � �7�
O�u�,)��B@��YU��if���������������������]Y��IE��>:��.(��������QO������������������������������������������������������������������������~��}}��||��{{��zz��yx��vu��__i�--3�..;�(� � � $� +� 5� A� M� W� b� h� g�  C� -�r� �� 
q� p� o� n� n� m� l� k� j� h� e� `� X�O�KQd�{|o�NMH�JIF�JIF�IHF�IHE�IHE�GFC�('%���iifV                                                                                \_U=��������������������������������������������QR\�  �  � � � .� D�\�j�~�.(��FB��ec������������������xx��db��[Y��QP��EE��77��&)������_`�������������������������������������}~��{|��zz��yy��xy��xx��ww��vv��vv��vv��uu��uu��uu��uu��tt��aal�/.4�00=�(� � � #� +� 5� ?� K� W� _� b�  @� &�
h� �� 
q� p� o� n� n� l� k� j� i� f� b� Z� 
R�"*U���v�YZR�JJF�JJF�JJF�JJF�JJF�KJF�KJF�774���                                                                                        ���������������������®��ï��İ��Ű��˹���������#$I� 0�  8� H�[�o���+(��:8��MK��ih����������������������������������np��WY��>A��'*���� ���� ��fg��������������zz��uu��uu��tu��tt��tt��tu��uu��uu��vv��vv��vv��uu��vv��uu��tt��ss��ss��st��rr��``k�005�-.;�+� � � $� +� 3� ?� K� U� Z�  =� &�e� �� 	p� o� n� n� n� l� k� i� g� c� ]� 
T�N�swr�mnc�KLG�JKF�JKF�JKF�JKF�JKF�JJF�JJF�??;��			G                                                                                        _cX*���������¯��ï��Ű��Ų��ǲ��ȴ��ɵ�������������4� :� Q�
p���/2��FJ��_c��x{�������������������������������������ik��QT��:=��$'���� �� �� ����"&��ln����������~��oo�kk}�kk~�kk~�mm�nn��oo��pq��qr��ss��tt��vv��ww��xx��yz��{{��||��|}��||��ggr�116�/0=�,� � � #� *� 3� ?� I� P�  9� %�
d� �� 
o� o� n� n� n� l� j� h� d� ^� 
V�M�RVg�|r�PPK�KLG�KLG�KLG�KKG�JKF�JKF�JKF�JKF�EFB�"" �                                                                                                �����İ��ű��Ʋ��ǳ��ȴ��ɵ��˶��̸��κ���������xz�� 0� B�^�x�&(��;@��SV��lo����������������������������������tv��_b��IL��36��"���� �� �� �� �� ����/3��xy����������uv��kk~�jk}�kl~�mn�oo�op�pp��qq��rr��ss��ss��tt��tt��tt��tu��tt��tt��ss��__k�..4�-.:�*� � � "� *� 3� >� E�  2�  �	a� |� 
m� m� m� m� l� k� h� e� 
`� 
W� 	N�29[���y�XWQ�MLH�MLH�MLH�LLG�LLG�LLG�KLG�KLG�KLG�HID�2                                                                                                793�Ű��ȳ��ɴ��ʵ��˶��͸��͹��ϻ��м��ӿ���������Y[v�5� L�
d�|�.1��CG��Z]��nq��������������������������vy��eh��RU��>A��*-������ �� �� �� �� �� �� ����<@������������������z{��yz��yz��yz��xy��ww��uv��tt��qq�oo~�mm}�jj|�hhz�ffy�eex�ccw�bbu�RRc�))1�))6�*� � � "� )� 2� 9�  ,�  � 
c� s� i� k� l� k� k� i� e� 
`� 
Y� 
N�")U���y�ef^�NNI�NMI�NMI�NMI�MLH�MLH�MLH�MLH�MLH�LKG�774�                                                                                                        ~�vV�ʵ��˶��͸��ι��ϻ��м��ѽ��Ӿ��տ�������������9:]� :�Q�h�!#~�25��FJ��Y\��il��tx��{~��|��y{��pt��dg��TW��CG��15��#��
�� �� �� �� �� �� �� �� �� �� ����HK��������������ut��ll|�kj{�jiz�iiy�hhx�ffx�eew�ccw�aaw�``v�``t�__t�__s�^^r�]]r�\\q�PPb�((0�&'3�+� � � "� )� ,�  %�  � U� h� 
c� g� i� i� h� e� 
`� 
Y� 	P�P�x{x�pqg�OPJ�NOJ�OOJ�NNI�NNI�NMI�NMI�NMI�NMI�MLH�FEB�                                                                                                            �����͹��ϻ��м��н��Ҿ��Կ�������������������������'(M� @�
T�h�"#~�35��BF��PT��\`��cf��dh��ae��[^��PT��BF��36��$'������ �� �� �� �� �� �� �� �� �� �� ������NQ����������rr��bbw�]\p�]]p�^^q�__r�__t�``u�aav�ccw�dew�ffw�ggx�hhy�iiy�jjz�jjz�^^k�007�))5�/� � � "� "�  � � P� 	W� 	Z� 
`� 
d� e� 
d� 
_� 	Y� 	P�
J�ors�z|o�QRM�NNJ�NNJ�NOJ�NOJ�NOJ�NOJ�OOJ�NNI�NNI�MLH�)('I                                                                                                                GJB�͹��м��ѽ��ӿ�������������������������������������E� B�S�h� "~�-/��8<��BF��IM��KO��IM��CI��:>��/4��#&������ �� �� �� �� �� �� �� �� �� �� �� �� �� ���� ��_a����������}}��ml|�hhx�ggx�gfy�ffx�eex�eew�eew�eev�ddu�ddv�ddv�dcv�ccw�ccw�VVh�,,5�((7�/� � �  �  � � D� K� O� 	W� 
\� 
^� 	\� 	V� N�I�gjo���v�UUP�OPK�NOK�NOJ�NOJ�NNJ�MNJ�NOJ�NOJ�NOJ�NOJ�>>:�                                                                                                                        swkB�Ҿ�������������������������������������������������"#L� @�	Q�e�x�#%��*-��/2��14��14��-1��%)�������� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ����"��hf����������ss��ffy�ccv�ddw�eew�ggw�ggw�hhx�hhx�hhx�hhy�ffy�eey�ddx�aax�TTj�**5�''8�0� �  �  �  � 8� =� B� K� Q� S� Q� K�H�djn���w�UUP�PPL�PPL�PPL�PPK�OOK�OOK�OOK�NOK�NOJ�NNJ�FGC�                                                                                                                                ���}����������������������������������������������������*,S� <�N�`�r�������������
���� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��N�M�..��jk������yy��ee}�]]s�\\q�^^q�^^q�__q�__r�__s�^^t�\\u�[[u�ZZu�XXu�UUt�HHf�$$3�""6�2� �  �  � ,� .� 5� =� C� E� C�D�fil���t�XXS�QQM�QQM�QQM�QQL�PPL�PPL�PPL�PPL�OOK�OOK�MMI�+                                                                                                                                "#
��������������������������������������������������������:<`� 8� G�X�j�
z�
�������� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��M� ?�  g� s�
��8<��xy������{{��hh}�``r�__p�__q�^^q�]]s�\\t�[[u�[[v�[[v�[[w�ZZx�YYx�PPj�**6�''9�3�� � #� $� )� .� 3� 5�>�eif�yzn�WWQ�QQL�QRM�RRM�RRM�RRM�QQM�QQM�QQL�QPL�PPL�OOK�))(V                                                                                                                                        793��������������������������������������������������������UWr� 1� =� J� Y� e� o� u� x� {� ~� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��O� ;� a� q� |� }�~���DH��~������rr��``t�ZZm�XXn�WWp�TTr�SSs�QQs�PPs�OOs�MMr�LLr�JJr�BBd�&&6�  2�-� � � � � !� $�2�Y]W�df\�MNH�MMI�PPK�QQL�QRM�RRM�RSN�RRM�RRM�RQM�QQM�QQL�996|                                                                                                                                                gj`%������������������������������������������������������������;� 5� ?� I� T� ^� h� o� u� z� }� � �� �� �� �� �� �� �� �� �� �� �� �� ��S� 3�  b� n� |� ~� }� |� |� |���HK��vv��yy��gg��WWp�PPl�MMm�KKo�JJp�HHp�GGp�GGo�FFo�EEo�CCn�==c�$$7�  0�9�� � ��&�EF@�GHA�<<8�CC?�IIE�MMH�PPK�QRM�QRM�RRM�SSN�RSN�RSN�RSN�BB?�                                                                                                                                                        hl`4������������������������������������������������������������+-R� 2� :� D� N� X� b� i� p� u� y� |� ~� �� �� �� �� �� �� �� �� 
�� 	��K� 6� ^� l� |� ~� }� |� |� |� {� z�	{�!��Z\������{{��ee��UUt�OOp�NNq�NNr�NNr�OOr�OOr�PPr�PPs�PPs�KKh�++;�%%6�7����//*�--)�++)�441�<<9�CC?�IIE�MNI�PPK�RRM�RRM�RSN�SSN�RSN�FEA�                                                                                                                                                                mrgC������������������������������������������������������������de~�	5� 6� >� G� P� Z� b� j� o� t� x� z� |� }� ~� � �� �� 
�� ��<� @� \� k� z� }� }� |� |� |� {� z� z� z� y�{�%*��_a��{{��ll��XX|�LLp�IIn�HHn�HHn�HHn�IIn�HHo�HHo�HHo�CCe�''8�""3�  7�  �"#���#$!�+,)�341�<<9�DD@�JJF�NNI�PQL�RRM�SSN�SSN�FFA�                                                                                                                                                                    othG����������������������������������������������������������������/1S� 1� 8� @� H� Q� Z� a� g� m� r� u� x� z� |� �� ��~� )� @� X� m� {� }� }� |� {� {� {� z� y� x� x� x� w� v�x�(-��\^��ff��VV��EEq�>>i�==i�??i�AAj�BBk�CCm�DDn�FFo�AAd�((8�&&5�00C�����$$"�+,)�441�<<9�DD@�JJF�NNJ�QQL�SSN�GGB�                                                                                                                                                                            mrg>�����������������������������������������տ��ѽ��ϻ����������������� F�3� 8� ?� G� O� V� ^� d� h� m� w� �� 	��Y� � E� U� j� x� z� z� z� z� z� y� x� x� w� v� u� u� s� r� p� o�s�7<��st������mm��ZZx�SSp�QQo�PPo�NNo�LLp�IIp�IIp�CCf�'':�##1�**A�����$$"�+,)�341�<=9�DD@�JJF�OOJ�CD?�

	                                                                                                                                                                                    kpe5�������������������������������������Ҿ��м��͹��ʶ��λ�����������������#%J�2� 8� >� D� L� R� [� j� v� n�;� "� B� O� g� r� t� u� u� u� u� u� t� t� s� r� q� p� n� m� k� i� 	f� d� 	a�i�BE��kl��jj��XX��IIo�CCi�@@j�>>k�==l�<<m�<<l�::b�%%:�  /�++C�!����$$#�,,)�441�<=9�DD@�;;8�		                                                                                                                                                                                            lqe*�����������������������������Կ��ѽ��ϻ��̷��ɵ��Ʋ��ï��ʹ�����������������.0S�3� 5� <� I� W� ^� H� � � 9�  H� ^� f� i� j� k� l� l� l� l� l� k� k� i� h� g� e� b� `� ]� Z� V� R� M�J�Z�GI��jj��aa��NNz�BBm�==k�<<l�;;m�<<n�==m�<<d�%%;�  /�--E�  #���! �&%#�,-*�441�'(%�                                                                                                                                                                                                    ,.)�ɴ����������������������Ҿ��м��ι��˶��ȳ��ű��®����������²�����������������]`x�D� E� ?� �  �  �  '� =� N� T� W� Y� [� \� ^� _� _� _� _� _� ^� \� Z� Y� V� T� Q� N� J� F� B� >�=�-0P�_cl�{}��tu��nn��``��MM{�CCo�@@n�@@o�AAp�CCo�AAf�))=�##0�11F�##"�  �  �"" �&&$��*      
                                                                                                                                                                                                        ���y�������������Կ��Ѽ��ϻ��͸��ʵ��Ƴ��İ���������������������������������������������*--���  � /� :� >� A� C� F� H� J� K� L� M� N� M� L� L� J� I� G� E� A� ?� <�=�A�48T�_cm����������u�kmd�OOM�GH^�dd��ww��dd��OO|�DDq�AAo�??o�??n�>>f�))>�-�66E�(((�$$"��

	�   K   8   &      
                                                                                                                                                                                                        zsI���������ҽ��м��ι��˷��ɴ��Ʊ��ï��������������������������ȹ�����������t��ê��Ծ��Ͼ�����~���MPi�)-N�?�7� 4� 6� 7� 9� :� <� <� <� <� <� :� :� 8�;�@� $K�8<Z�^cn�}���������������y|q�jlc�ef^�_`Y�IJE� !�::@�kk��qq��mm��[[��JJz�AAp�>>o�>>m�<<d�''=�  .�55D�!!#�d   S   P   E   5   $      
                                                                                                                                                                                                        ?A:�����м��ϻ��͸��ʶ��ȳ��ű��®����������ò��̼������ǹ�����Y_M�JO?�^cR�sxg����������Ⱥ��������������÷���������x|��bgw�SWl�HLg�CHb�CG_�BGa�EIf�MRh�Y]n�jox�����������������������������{}r�pqh�ijb�gia�fh`�gg_�YYR�DE@��YZT�fga�abj�ii��ss��pp��^^��MMy�GGq�EEo�CCg�++>�##0�''D�<   B   H   G   ?   1   !      
                                                                                                                                                                                                            ��Q�͸��̷��ɵ��Ƴ��İ��İ��ǵ��;�����������w�NT@�KP>�\bP�lra��t������������������������������������������ǵ��ͻ��Ѿ��ӿ��ҿ��Ѿ��ϼ��˸��Ĳ���������������������{~r�tvl�prg�lne�kmd�klc�kkb�hia�gha�ef^�PPI�00+� !�eg`�de^�ac\�`b\�]^o�aa��jj��__��OO��AAs�>>l�;;c�''=�*�**L~/   5   <   =   7   +         	                                                                                                                                                                                                            .0*�����ɵ��̹��������������±�~�n�KS:�Y_K�ip[�nua�}�p���������������������������������������������������~���|���z���y���w��u�|t�{}r�y|q�xzo�vyn�vxl�tvk�stj�qsi�org�oqf�npf�lne�lmd�klc�ijc�hia�`bZ�MNF��OOH�ijc�de^�bd]�bc\�ac[�`a\�\]t�hh��uu��oo��]]��PPu�JJj�11E�*�--`�(   (   /   2   .   &                                                                                                                                                                                                                         ^aZ.������������z�k�QZA�RXB�nv_�~�p���}�����������������������������������������������������������~���|���{���y���w��v�~�u�|~s�{}r�y{p�wyo�vxn�uwk�svk�rtj�qsh�org�oqf�npf�lme�kld�klc�ijb�YZS�@A:��hh`�iia�de]�cd]�bd]�bc\�ac[�_`X�BCLsDD�Coo��||��ll��YY��LLp�22I�.�))d�       $   '   %                                                                                                                                                                                                                                 >A6=PXB�goW�ry`�z�j���}����������������������������������������������������������������������}���|���z���x��w�~�u�|t�{}r�z|q�xzo�vyn�vxm�twk�suk�rtj�prh�org�oqf�mof�lme�kld�gh_�STL�#$ �34/�klc�hh`�fg_�ef^�cd]�`b[�DE@}        M	OO�Cii��nn��``��MMy�..I�0�&&j~                     
                                                                                                                                                                                                                            :>33����������������������������������������������������������������������������������~���|���z���y���w�~�v�}�u�|~s�z}r�y{p�wzo�vyn�vxl�tvk�suj�rti�prh�oqg�opf�mof�lne�^_V�FG?��Z\T�fh`�gh`�gg_�de]�FFAq                        ++sYY�Rzz��zz��dd��;;T�1�--zz                                                                                                                                                                                                                                                      JLE~�u}���٩�����������������������������������������������������������������~���|���{���z���x��v�~�u�|t�{}r�y|q�xzo�wyn�vyn�uwk�tvk�stj�qsj�prg�oqg�opf�ikc�UVN�++%�..(�hi`�gia�\]V�340S                                            &&zPP�fgg��__��>>g�1�''{w$                                                                                                                                                                                                                                                          )*&VYPG��z����ڢ��������������������������������������������������������}���|���z���y���w��v�}�u�|~s�z}r�y{p�wzo�vyn�vxm�twk�suj�stj�pri�oqg�opf�ef]�JLE��LNF�MNGv(                                                            33� PP�\\��GG|�''E�%%x}8                                                                                                                                                                                                                                                                      "$ XZQC��w����Ŝ��������������������������������������������~���|���{���y���w��v�~�u�|t�{}r�z|q�y{p�wzo�vyn�uxl�svk�suk�rti�psh�kmb�YZQ�$$ j		.                                                                                11�3ZZ��cc��AAe�22��Q                                                                                                                                                                                                                                                                                	;=7QTLN�������������������������������������~���}���|���y���x���w��v�~�u�|~s�z}r�y{p�xzo�vyn�vxm�sui�mof�RSLx9:55                                                                                                    HH�@bb��UU��;;��Y	                                                                                                                                                                                                                                                                                                    <=7=?9;]_Wjx{ozxzo�wzo�x{n�vyn�wym�twm�suk�qsi�oqh�nof�jlc�hj`�eg^u9:4Y01-(                                                                                                                                jBB�JVV��CC�wa                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ""pRR�LQQ�@                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            55�FF�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ��������������������������������������������������������������������������������<���  �������� ��    ��������� �    �������� �    ��������       ��������        ?�������        �������        �������         �������         �������        �������        �������        �������        ������          ������          �����          ?�����          �����          �����          �����          �����          ����           ����            ����            ���            ���            ?���            ���            ���            ���            ���            ���            ���            ���            ���            ��              ��              ��              ��              �              �              �              ?�              ?�              ?�              ?�              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              �              ?�              ?�              ?�              �              �              �              ��              ��              ��             ���            ���            ���            ���            ���            ���            ���            ���            ���            ���            ?���            ���            ����            ����           �����          �����          �����          �����          �����          �����          ?�����          �����          �������         ������         ?������         ������         ������         ������         �������        �������       �������      ? �������     �� ��������    ����������    ?����������   ������������  ������������������������������������������������������,�[remap]

path="res://.godot/exported/133200997/export-9ff6a75617b56735244e0df0ba1f71ca-AverageTime.scn"
�p<���I[remap]

path="res://.godot/exported/133200997/export-b0b59308ebad1c5daf28308ceba0275e-RouteFinder.scn"
i��8��:[remap]

path="res://.godot/exported/133200997/export-3bb9356b802a82c6f2dfde91dd7520b6-SegmentTimer.scn"
������A[remap]

path="res://.godot/exported/133200997/export-7cf3fd67ad9f55210191d77b582b8209-default_env.res"
�)�`�;p[remap]

path="res://.godot/exported/133200997/export-bcb0d2eb5949c52b6a65bfe9de3e985b-Main.scn"

�� �����W%�(��PNG

   IHDR   �   �   �>a�   	pHYs    ��~�    IDATx��}XUg�5����^QPT,�� X�w�� M@�`G�"���{�b�-�Xcb�L��$3����~{8��d����s��g�眽�۾�n�������n��n󜝋���.�{�����o	�k��޷o�#}�t���������ەn���uPP@t��Q��fŏ�>nt������G>>2�yLJҳ���#G�_�����48:rr��.m}��5��Kt��6=<��8p�*Oϑ!U��������[�R%m[�w�޽���fdO_�{x��y�S��`r�,L"&�������5cgLŘ���>y�2'b��	H���	�4nǎB��tP4�X0<-Q)I�D�_׽_�4g���eʕ+���}�t�?4tGƀ��ru��-W��?��_�j֭]���`ϑ�&̚�z������eΊ%��|	f.]���C0e�d
�sg��� �O���S2) �?)#����B�h�c�H%�شĤ&��Qɉ�LJ@�������Y�n������7�vrjq��o�ⰰ?�w�����ͧ�)[�Կ�s�����7���;�󨩓�-ڴ��k��`�j�[�
9��A0k�bd� �bڂ] �1qN62H����i�S0f���2	�oX��B�?2��cF&#��G'S �	6"	���W�n(]����=�_�ܳGj�5�K!ca�5���=~����1�;�ëA�����ۦX1c�mt���WL�7v��u����ץ�6a���� �N,�O�W��;[� �gb��������?uba�7�~M 1#�����I#0�H a1Q�9p �5n������DH԰o�jֲE���;Gկ_�p������,(��ann�t�V�����kcS�D#\b1v&��E��ͥEƼ�U��m��=۰z�V�ع"��[6`�A kW`.0[�l� s �������*�O0r������O��^��Oլ_�~#� <.����%˖A?GF�4l~���{D�
�+��w&5n\첯o�C�F]�8j��g�����t�Q�Q��ZY	���DY���g���Zutk�1���A��~
NOD��Q�;�7���$�F] k	`1�H�J ) !��������������o����Q�_'?�ď�����1"����Cͺuдe����H
 �C�0$4�E�Nc�W�P��;{0�;ث�灨�����~��gz������fU�~]��������rDe�!/ω ��.�w��Bw?��ܝ�?�9�1�F��_x�8$d��ع3��r1��Z00�r%�l
�p�&�q3u�?���O��њ���O3�~�|��u�����C�����.;�L�
����(�~E~��P���bHX=��鑴�S'����˶������N��EB���ڼ9�W�~h�F�llj�T'��zD����w��9��('k������<N߼���ƥ�����1�M�~>�	�Ő�(��P��b2-<w�
%�9J K��t���� &�����_
�v�7r���&�n( 䇑��}��`x��
U��K�^��@%���C��������ܒ��Ê��L@J�ވ��^NN��Q�`����֒H
��	�2�h�������?>{j�CWϿ8��9�|{/�Įs��_<�W/���<l?~#�2ѡO���A�P�$�"9s<�2��� ���f28��X�s6އ�������ѫp��U���N�����p��E�r{Ν��ㇰj�v�]f.[L�d!q�h�R��i����aWߕD6n��j�D�p% !��@nH�DGcqP&S$I;"��a��hߠ�?��V�Cw{�q�,-�tg�ўhM46Ѽ�����\:�W�v���c7.�|T�z�(�K����q�8s|[I����q�8s�
�ĉ�g���{�n��aiI��sk����Kgq��5\��c\|p��[�<.\��Ic�0rX(b�ð�]��A�=��]�ٷ�|���S&b>s���0���N!mEΚ��|B�E�����O��t��(Y�� CBs����d8X����		�����;#���<=��
�Y�:?vj� ���D�3�N8��2&��~��Q]Oݻv���[���p���r�.���'���1l;u[������{�����>�×�cש�*�'O��-g���Z��KXG˝1q�z�@O�Fp�P��-�������&hK��,s#Xhϻ�؆GW+3t(]>uk¯]�Ql�b�ʥ*��`h���<�op��uEuz�..Ȥ�X6bV�YC�`�|�>�V?�ڮ�X>k�D'g�שU낥��P�"){^&�'�@����ݿ#����?�{x�?���$����0x��ya`��#�z����ƚ};���.\�s_|���ן��wļ�9pp�G�reQ��̒�ԔD�p7ّ�z�D��Ct�4A{ZhGy�]^�+��y�":��@��X�c���ߦ%��!c�45�(����t�]:cK��#Gb.�c�܈N�/任#��� �5�C��j�
6D��uQ�z�/m���S�C�1����|�96)O��q�]�8��6�R��]�	#/p��Y�z��'�` ^`���Oỿ�����N9��� t��z�w�]��ۑ|J0eF{>�I�'��_b��	��@"���1Pݏ�}yH���><�$�ބ�������9 �b��а %K��0+8�������:t@<����#xlO�����į6���5k�F���.[��SSS{��䇏����僋�z�+/���{����=��3n*/p\�Y��z	����ѫ����/�&w.�5sDsS8��vDWs�`!O,���)E`��)�z_�"�If���""�aD8Jۘ ��#�q_����~U*`B��X�/��ި�=1��1��#�n~8��89�}�z�Дd{98��U�UC���Q�f-ԩW�M�Բ���6Xlem]����tO�q���٫ۯ���g��O!��\zr�?/p��_���yf����赋x��~��/���WX���[�:hN�ۈk':�k.�/1��&!�$(�业����9<L�ЋB��&��d��b�6�m�ג�Db�`����"�EDؚ`(�!<F�/�)^XĊ ��O<�]�"�VM�����%��I�!�y��N�'�Z$����U��CA��FM�h۾:t��6���llm�g��K�v�����w�x�[����g�q�Ӈ��
N޽��n?{�?��G����~�|x׬�,^�w'���^$} H⇒�Hb8�$Y��L0���oj�X��B@D�����Q6o#�H�1�F�AJ<&���۵���$��0�L�����Я���A<��xz�I� �>'������F�+V��J�++믭�oL�[ȇ7��n��;y�f^P����7�"��;����7��
%�/�SO)�O�P��>CE ^�������ӷ������C���N��B|���C���b1�H$�)D1�CL&Qs��`��)Q������FScm4�!F����V��bq�?r#"�9p F�����G�ң��E3������/���7��6L��ׇg�f�D��W���o�O�ogD>Eԝ��Iayt�|خh�r�7���F����ų��}��)R r���Kܡ'���H>���!.I>��<��%~$�_������F�m����{�ć�D<IN.D�Xb�OL ����"&�ౝ���?=AE0JD`] �1Fbx�3�=��Zb�}=�	ªѣ1'6c�����h�q]����y4 �BhC�o�䮵$y5k�F����W�^���)�|#�*�{�G߾J �����(�2�7��x��ly������~�"����_<�C�������?����A_��h��p�̴,~��F|�`�Y{�N�8b�$5��Lb6E0�!����(�@z�X~�+���ok�i��`�����/$��Ñ<` ��#I�����H�2ַb�o]�ʚ����9jT���MшI`����N�xQ@]{��Oo�|M �EG/7��G�w�ɽ�WI���?��ϟ*����@�������əp-YΦZIו�o�e�b�:�tKOdXj$&ab!���h�EЂ"eug�~d2�[���RS1?=�C A�%1å�#�	2�C+O�Q=ݽ��ő�0���t��h�m+�G%�#���x�~�J��텎]:���]z��|�=<���\�ukѶu��n�I\�c|��l��g"�'�"�"x����o?��P��=	�f.��/�D1��ڍ	�|
a�.�z�Y��"a8�{	�/L*WK�t¦��r�$�HLD2k��L����S���#��$1>+k�'q�	��P� �|��
2FAT!���"��+�Ǡ _�GEZ}W�|������=����oն�ߛ��cZ��'n=�����ΗRt����7E����_��7<���\��T��-��ۘcTKL-b��6�Xhe����KL#������):&�����4k���'p���$����E0�]lIO�Ƭ,��ݏ��D"�O
�A` ���!C��c$!U@��/�I`+f�m%�|;SS��﫣�ވ�Ñh���,�I�J "*q��ч�2&���>�ѽ��7|z��s�F���ܫ���{�ʀ���2�'I�$wy�W(��,�n�p�/��e��{�*�5�Wc�=��\���K`R�rȩZ	˫W��ꕱ�rl)S��Xc5����O�, ʯBa�{'Q=�	zX� ��kc��a�̣��8/D� �B��H$�|��� �ħ�3H^�pЂn���eˠ,�/F��"���������|/k�؉^'6*�'������{���@��j�j�W�cF&y��u�/��^Sc�J��󽁈�!�*C��?��_��7ܿyݙ	Ki���᥋#�JEdի�%��ؼ)v�t�^b���6���5�`'߷���(���������om̐U�r""�}���6Ӓ����.5,#��H
a$c� ����tߗ�������D3,8��%�oV�4*�'�u�����z��#C˒��hGyܥtQ�E�33'�7���F�k�n&����?�����ֹ��>�<đ9v��;Mo �=o !��W�*�ܹ���A��Y#�\i��]9M��.x�����|p��]=q��GZ6Ł�u��Bl���B]Ӥ��!�$k3d׬��,�,\�-`�ر;\#�d�G�p�&БJ���T�H���8�M��5k���ʠɯFT&���5:�D�"�"�geH���@�'_�Z���Ð:i��Oo#�u»1W�f����6�w ]�Z���;%���Ď�퟾g�P��Ƨ�U����]�h�@Y~����e0��`�sl$����Ɖ`��åȡ����Cp�ϟ��G[���u��\)l�4C���~I*o�6Ŭ�屦OOlgűz�d���E� ��ӵ��O&R�Siي�p�-�q��GEaTt�B��u�fpn�M�*����jS27��F#ޏ&�C�p;�D����D��E����1�T.����-�e�P�
]����A�F]���N7pޙ�d�N�qe&/_�'n_�I������{�z2���V��}��#˔$��H~sl��C��8���d\77Ǐ���鸖���aCqaP���c�N8P�v/�U�YFx�f�)�5,�̞��+WbŌ,LIN���bttFEE+R� ���x
 �B�* Y���"=?�knF�oѠ>���o��ք�z�@D��0�=��(�AD�[DA�*e�6:�F$��@a»�x <��o�.S�?3RȒ����ʴ�,��9�W�iB0�')�����-�����yb���1ժ ��I�� ?\��L��dg�����`�|ܟ;w�Nƍ�T\�ǅ}q��3O�[���BȑP`�nLgb��C;�ș�s۷cɟ�Do��Q�¬{���3G����d$'c����Çc�X���ta��k�1;w�շ"�K�R%�1����'M��i!>��Fz�ct!��'1�Qm�O�Ж��|��������-[�����Ź�d��,ݒi۽Ob� k��G��<�\��ǯ_��٣�Ќ���L�l͐Ƹ?�a}�������||,ndN����x�n-^l߆;����x�t1�Θ����¹��$0��U�Ky�gXj0a���h�$v��EX3s&�H�e�?.6��c<I��			� �	L'
(�I�ܗ�b�	Z�rpqt��W��o����\[+ �����!��C'���
[�" "��`����`H��H�:����7����>��Ե˟K�)������aA��O���G���Q5g�K�p����4�<���0��ݖ6Vp1�&rX�ϨR	�����?��tw�h�Oׯë����9��x�=��[�(op;c<��D�b�>8՞I!s����a�@��m�1�~ml��Ł�˱a�|�?N=���1��=!.�|�lF�E�������S��0��a��ј6f������Z99�}��h�l_ȯ!u��|Y�"+���D[	�����X��$7�d�AD��`(EH��zؙb���Hd8�J����>>����<��dA���V,ݺ~��ㇰ��!�f�bP8w�=�]�D'p������W��@׺u��������+�	���4Ɗ6.���'"�pe�T|L�y�">g����	<��;��p=!�}���Q��W�$6�ϲ0ü�ձcX��Z��k�`	�~ʨQ�HIQ+�$��)�B��L>�ԏ��uo����	�1��������eRu�.�olV@��� �OJ?���@8ɜB$ؾ[ ���aD`'�2=AIk$�LB=�_�t�n\��Q�r���v�o!@��M������>�LKiʪ]Y����al9q����g�����?�ؒ<%U=l�j&�p4�D'��E����5����<�q ,gf��)���`�>GK<:G}��p�>8��í[�H���_���*�]�A�۶yǏaϦ�X8k���g���1�����	�1}�XL3�)�i���1���X|a!A�A,�Mi��аD	E���|g��YkK�By��.�Hz��L0��&}SD�"� ����W���He����O���Q`�r�+������ r�,߷��l8��UǕ{�"w�j�����̱H���/��-��Ά�Q�'����!3���F�"%�R�2�5���5��#�pn�\���Z��7l��	���^]����)�)e�ar�
�C����h����av6fN��,�.G��L�lgS���,�b�,� f�O�C�ر�A7?]ܾ�$-�HEc~Z�#�, ����������hK�<������b�A vo
`x!���`����>>,G��@��4t�
/�ޝQ�AC�*]E��9"*��;L��w`�5�v� �&o]�i��#a��%F�gd0���s� l`>p��UԩXQ���f����L���	>iQ	�y���|�=_�Y�?�݁oϟ�w7�������g��w���x�h!.�R׻�#�fC������98�s'v�[��YY�"��ǍS���
$9K ��E�=Q��_����-7n<����ջ95�w�5u��ke ��0->D��������������V��P �� ��#1-CX�Ȭ�B�����w�Jt�vŊ���#ߛv��˗��$3��_��h.b&��_t��={mzx��O'��٫�����]r�
�$����W�����NW��y�:���k{�VL>f��hN6�,Y�[��}{����|�^�޽_��s��鲅��n.�?�c$���ȝ6�t�V$�k���0�=��,�@&4��~�Q|W`l�$&�x
_���dD��oN�wo�F��j���3"�C'_~o��F~Ia��Qt� ����9���O��_ /A�C�>���B���*��ԥ��5�a<e�    IDAT˖�����������z�[�o�޾v���:��C�^]Ѫ�'�۷B�� L^������'��O?������������'Bq�<��6"��'l��C�j�d[g�gY����½iS�`V60��g�ww��b���j�0��[�K�f�8.	�"T�J�$z2	��8/�O�3�����C��ǘ�B@F���ɘ�9��|k~I����ѠXQE~M�|}���/{
�t�c�8[��$�e����dj��eLT�� �+�C� bл�%�G�!0r:u���Q�6�1�.JO!	�Ј�����t��ܻ;�­o��9G���ދ'�Ä��wp��C|��?5)-����>����� d�f��9�W*�L�!N�k�=�!���"#p�?�6k��#Sp�j�a=����K8�gV����`ќ9X8{60��g�?/kr�OG=��)S0{�d�3�Ww.!��+DAY�L��,&��CCѲiS�5oN��T�_�����h���/L�/J�eq"�O&�)E�UL.���f�A8���D�p%`,�(#/J�)�!�!�!k:1�Z8�R��ֶ�[�F܈D������~<x�P��� �vp�|pL8�0V_��.�>y�����>��L�����?���7ѱby��d���k�6���;Sd���W�������p�q#�vm��]�p�oo\���"��&ɽ{�(n]��SL�6�Z�L�͛�����
K(�%s�b�F*�"�� XZ�AP�&$��(�3��X<���9�a$	��hE�݉*E��:���Ԉ|��>:��$>V'?ɹ.�!�Ōp03Ǽ�&�PH �+cD�� �E0��@������P�f-��Yb	�峤V���7��M�/�߭���Ϝ������.`ۑj��-�t�zl?~O���ny$Z��*��[�E���<���!6{���`�8֠>N�h�3���g\KKŭ��q��!l]�&�����Џ(QPKE��b0x%�/a�\9��S�"v�08�����uxBe*���iC�b�B��N�p+m���j�/'/�y���'P ��fXR����_!��\�-V��:!��JJ?��mP�L)�P�zug.3��O��=<��������o���SG�j�f,޸F����ŏo�����V����V��'�s��,4d9<9�=֖8X�4�T������M��|��ɓ���n3c�ff�[Xn��m7bۦMخ�Y�l��[��|�F�f=ƺ+�v�2�^�+-�=�x��"bE�V-Z��1�^Q;5�+������ޮ��^:��=Ì�O�a,����DB�)��̰�H/�/��&�|/@�-[	�I�7���Q�D	��ڢ��>b�0I����ǆ���K�;��)����׋7o��u���*˷oģ�_a��EjnG�؟l��V�?C�L�|�

f;�{m�p�Vw���i���;v0�/�ʅ�j���P��
� ֐�K�b�2b�2
`9֭\��Ć�+�(�Z��f�r$�HP��պ5��ڨ�_�D�ϯ!s�����~�FلO��Y`F�&Ȭ_iŬ�����
��%�&3��-�y���׼���º{#(&+U��]Qԫ� ��`|��ã���շoο$��!�}r�,�[��x��?���=GHg/�����/�E��0c�X��&��F����'V���ۘ1g�s��	�˦�oYG/�v6Ѳ%�(dҺ7����:Z�� " �P�X]"�Iqqh�l����El�2�_WM� �0�Z�2"?��-6F�����~��ega�W��Xqv�zY�E���Oa	(��_(,�a�5��*P�"z���L�򰶶�O�����A��Бy�1��ty�/	 }rƢ�+�@��70G�[�y���̕p)^Tm�襯�A��З_Yi�wԬ]!d���zX����ܾ��9�][��|�	B��՚���ד|�:�|�5@�a�|q������H>\����X~�����4nC�	f�m�ͥ	Ę
%�{�(||��]���G�����r��mX���"+�-��?�0������K�g�Af� "��4:�@1m\�GQ38�tB�j�T��ACБ/��1�=<<v���o"�z��E��-���^ѱ|1�H�,۶	�?}���)�����u�)���L�ܼ�/`���GXӦn]��cL���^�݋,5�Ɓ���څ�;wb�W���g�v�پM��F��]�w�V�cc�������g}����rݲ?pøJepn�<�7o������������رcȻ��{w�"��y̟:#�� ����x��"[m=�p�7�1v�@d�/����j̝�W�
WٚF1��!(wO���O�Mh��ᔽtя�	C �W�!�8w�8�{t��n�h+k�ʹ�/�B������i�������a}\<x�7oVֿ�!`�:�S�ư�m���!`��i�
;�����D�V�L�d�l���$�7"��N�x2S�������ď/b�i����Mx��-��"7��{���D�}|�ԩ��;ܹyg�nT^!��BD1K��\A��UA��!ц�{��Y/ ei)ss4i�������=<߉�}��M�'��T��%�T�-�t���y��Њ'QN����~��O4�`�կ��*�p�8B�ڻm�nߡ,Y�ZY8O�X�!#���t��g�z����[�62�$2�;��{89�.K'�&b ���9E�0��}Z��˘c��n?F�㣏>��Ç�9�cG�����󖓬^N�:�3�O3,�Ǎ7���3���s�/잕�1�-V�R��/���m�{ �`{�ۊ&Z3��1�0)k���;z����?�y��{�U�u�J�lƢy����3@گ
�0���>ֳ��i��Su�o����V"h���*�6O����q���7A�2਀�僢9&`�8Fr�@�P �#G½];e�5I~M!����wӽ��E��dT�ca�=�����|��g�z��r�G���!B8"���1�DD!���㏱w�fD6�����@��Z�(�w`�����Rs��%�0n�4-��� �:t����կ@f��B��[�0W��H�]���F�G�u��?�=Pa�◽�@�
�Ǔ|��)E�q��<�'y�O�y�Zڙ��p�8��Ǵ���)�.���߉�����^-�����Z�Y�h��/�}t��D ��������>��۷�;�]vһ����n���:���%����<DAօp��Q�(����w�p�]� +��toi�
	@ܿ�<�� �����1b�X��[ǎF��Q�\ڨQ!�����˕��3��ɹsT�]�/��ۙ9Z�]Yp��Cj�J��b�`}��������%�x�,�0����E?/ҍ
.]��6����ߧp�.�=��	�`tz���δ��$���V�����B~smO�P��@p��4m:�������p��e&�
y���w�P���y�{.]R�d �@BDRB��ׇυ7�KY2>XA�qH(���PLVS����V�����4���������ɩ��nSi'��4�gc�\I���Z�N���:o�e���uxT*�N`��%Zh۶'�C ��B�T��aj�P+����[g��>��+<�������+�x�y��	\�.�����3F��Ÿ_��J���I8�lA'����8ـZ�
��d���o��W���	�Kݯ������>\�����΍�9?˕�,=�(�!����] �F����"^Y~�]��2�7�!�{��7���.��..� �z�tSdϙ��l�׮@Z�N����g��]p)f��E�;������ZX �^`
L,3��&���vhgR��ǉm;p���a�u�n�<�*�j!YH1\��]c\�θ|]�1�U���%K�������ɯk����D+S���>moe�,�F��~��GE�]�P�@�uS d�bPb��#��9�391�SEe��;�Iwk���F�	 �${X���W��hDi&�5(֒&�/���c���@��k��_�����:��>�@������~��s�q��M�\�m,�୻O��1R������k�$L����{��V$�ьbi���������CE�u!�'PN��\9ѷy��0.�m�Ŋ��1��O��jz�g(�Z�~;�L�c)<��m�O�����?�sf�B��;wX������U�K��c��{���@�{���	�)�hO�na���B0�� �������j���{��@�#��������Nt(@!�k���_|Q�5uR��V��dY0Vo�,I��Gw15c���]�ٱX�e˻`��bit�]Ll�D�) wS�.b�c�Lq��	�հ�#&�/Y>�҉[�I<ɿ-�߼�	�����>���k����j\_v��
�v��� d�'������Sf�b��=T�@���n���s��W���+�F��K�%�3]<w^��sg������`����e��6�j�&`/SƖZ.П�-�LKXh��Y��cf��<?�h�H��{�� xx�.�_ƌ���>(��)����>f���6Y]g'{�"\zx��!j �G�$��,� !� �ɲ*���L,ц�;�&ֈ/j��$�<��eM��?x��9.�����kE�-q���I�5�}�\dp�9 ���y�Ց��.h�p�,C�qd��VU���-L�K/�}ܤҶ��O?�W_~���:2�'�\ܺX�X�X�X���@������{��;u���wLdزVu�0�v��Զ�����B� $H������qL��'�����i����#4>Y	���� ffg��
L:�.�$�O������u�"�f=w�r��+��\ʹ5q���үw	`_�15�	�i��-����	�Vӈ_l�%�3�$I4ÅI��w��Ǐ�<|� ��	BH�]��o�����w�!�uI"���?����D�suEssZ>/bhɒ83m~��[�Ș���K%����t����'i��]��[t��߆8��o��Հ��QKO�$����Q a�ZuR��W �h�+j3�*��	 I�ຕ�����h/-h� �0@0k��!��I�
H��.� ħ�XY�a�~|�U���z��}�X |.���Io�ܾf7�i��	�S��F��t3�54��1����+E�����<&9"�O>�O�<�S��ӧj����gj��ŋoA����G<��g��v�c�Q���\���	��_� �S�/��O����#%-��ӭ���o��/��kwUΠ{��!?�����U*����% CHJ�R�ė'�ٚb��b�UB0�_Ւ�8B�jG�ۿA̞3w�����y�H#�+k	�r-���97W�g�HBE&Z@��d�]��"�>���K����T������`�>k8����Q����c� x���|��$����/_�SZ��_�,"������3�����o�����SE��<��ぐ(n�����7�x[=�n^���C����s=|�P���Gj� 5)��.$ ɩj��(�hfa�����J�_B�~@�� |+ExR"<�vA;w7noC�0gn΄`R��F�����˥U˷m©;W1���rS�PBFJ+V�'�@��ú��w߀�Xc�z��	����-��W������H��.n\���bPo@<~ x�G
���X�|#"Ţ_ѫ|������o��Xyy^��e�0g����<��?�����q�{]�
�}^���g����
A�b"#ѤB9M � d,@F��q-}%RcޟGO��:�g)m6�� �H%P�HND��]e̟p/B!A��͝�A��8���S��.�"��Y�m#N޺����XK] �Z�5�ބVߐ�Q��q���`̟c����w�`*K��#┅JV.D	X�*�KW�U��W���;��{��ϔ��ʚ�>=z ���z�DάYj��ɓ��}��}^�g����駟 ���3�!�9=�3�Bp��YB��EU�Ȩ
p��v+�e��!r�?��6`,�P#� "�F�����ݤ�ӄ`�� rrsg~P $�)�&^��!�U[�u�jѯY��C	�B�L���񵉙%�q�
�T�?Ⱥ`p�0�� ��w��?�	_�p9����\ͪ)��/^�/�/��R×���/�#�	Y/?}�/5R�j%3-[���лuk4��B#++p�s�b�Ν�,|��S�;蟭>_>��/��
DM��2Pr '5Ư%|2;�UQ#T�|Â�0�! B� "��0��A$���$����ī˩26�BУ7�0��#:� �b��{h��$?��)N҅�,�v��ɿ ��}�������-����t�o�|���k�x���D��<ܾ�&%%�C���nڔ.�BY���Z���i��O��m[U b|�;��|�K����U��B,@CsmR9_VV!��_@o��F�^�`�X a�X���F2�
�v���^û�07'w�@¿4&��:�rI�����]�g�Zj#�mI~}_�`j	3�XUJ#�Т�p�w	A� rm�oimr�]�+#�y��|�`$�w�D^�R.��xWZ~צp`��P_.˿;Xh�/��V�R������E�y��G�I$1�c�	Ϙ#<{�AV���@����ٳ�6���HE}fOvP;��Y���L��Ji@���x� Bj�E����E@a	b�ܹ�'�0:�c����+h_Gw��L���6�j.K��?�%ݘ%���qD,_ȷ~�c�:N.$��M�f�Bn~2�'^���[I�sCe�R��?�ݷ��#��u�	koo�:�h���m�_*F�"W���*p���
牞�J�AKFb!�/��|��H������!CP���8I/Jȱ�����$Ob	mGP�{�/��`w���)�Yv��k{�1k���
 .-�La��B����3sg�еK��O�4S�T�tc戴1�a��5t_�,i&ؼݻw�{D`���=�d�''�Gz�Wo�-KW�� eޙ�g���^ݺ�m���lj�?O k�*$���� �!�9�b���f5�����>�
2�|h�DA%�\�x���<� �!(�<�F_��ɪ(��	F3I�*���(�� ވ�%4�/�����B�Nh�ڮ@����Y�@LJ��|��PM�.�,�Q�����c��(5�R��=@G줊ה�,_�w� ������R��M�5�J2iP䋵J��o�H��g�j0�@�����$�Ν;зo_t��F˪�����ڀ��<��k�UHd[W��n�Ya'+����Ș����1�T��\+�C�o�>������%J�B��SZ#�Oz�[��^�b�q�@���� F��ƌ����wPxb������QI	�����Zp�DV{/�����j���C�g򲢼	6�h�c�
��D0���	AV�k� _>� C���A��F��Q(�	/Tw�(佲����]���*WBM3}����0��>O �D��K�6�,j�ݱQ������V�Ż�
�<,_��oUܽ{7�}}Q���$܃�{K+{�/Я@�.� ] �#㐳v5ں�+�{�0m�t�
���Of�X��#���M�0R���n�'GS����]Y���.� gm$�_��b0�~m��wO�Џ?�����~��Wc�����ӧceBgŊ�B�Y�/SFm���.���*�3�f	���L��Sͦ�$�_�����w�<����|ý�w����;�����0�>;v�@��`8���I3Y�����M�	�-�O��0�ϭY��K�M[��m]�CW�n��[�oW�� ڸ�2\8�@�\?�p�t9N�7��aKW&s�9t�E��/�%W�X�-�uL(�~A��hD�J�y��R�����C�`�`�l)�J���u[�h1<<<Э�;�,�����od��_v��w�&��ek��)���V����%�/�2�]���yy���Q�AܼzM�V�ʟ�����nkCĆ5�u��!d� ԡ�m�5�V`W �|����P��ĩ+��<�����M[�~�6��J    IDATZ8�z�D��Wi��⠈O)�z�x�0u��x���C�+~���H~Ѵ��%�d�d�~���8to�VX!X�y�i�ޫLE�<�����@��0<��x���9s&:v��;�o���/ki�����&�dç\:nbY;�Ȝ�?�����Go^�I6�<g�����+���P���U��\�Â�߿�[����ն@ aF(l��%5��\�?����b��hզ��9��͜��� �r�T�J����?�[��AQ�h޶5ۻ`@R,��� ���wN&������+o�!�Ba�Xz�0^�F���P�nيs����1������B���_Pk��AH�'�o322�)������z���&��ZY�d��!{d�O�t|�r�s&sB��+�u���Ϝ�����%j�����<��
?[�*\A1��=�a]���Z�
C��AUS% �w �{� �L�逛/����M���-[��G�V���s+��U(bgW$"~��H�:���c�ݳ;�֮�j�c���صlzYiM���k��x����-!�b�+�t4�����@ڰpD��cTZ̛��[�����F��/^,X}+�3RSSё�^v���w��֛<4З�{�Xb��B~�8='�e<�������ϐ�3Gu��/��)�s:��UA� ''��(�6���;0�� Jj0���ǧ���[��-[�pFsZ8éEK����~{؀@���ǩ˦��͝P�Je4wi�+�����3ho��Nr�U���Y�W�2��CB�,bKJ�K�fI����֩�1�m�ث"|#80 QQQ�����;Y�/3w��^������Mx:5C-+�|��MZ������,c&�Xi�grf�s���ɞ){g�p��I�=��sg�����!�?Y>w�\����`l���_� ���c��d�:#�Iv�
�t4uj.���%K?��p���;J���@Y~Xt:v��uj�Tٲ�e~p�<�t�kWW�g�&-�Z����B^`�/	AGOFW��^f�L����H�Z�+3*�C�E`7����A�������BXh(ڹ��K�ci���Q>'3�
�޲�G6�ʂP~^F�J��b�3ټ�wE�6R�����!�l
{��?w��pd����(k�����c฾���#�Q9|�'OF/�N�,� #��(l�" 3��C�U�ݧ��JM,�Y�tެIo��H4qt���Q�_-��.m��������Q��=ʳ�n��y˗b��|� �P˖�YiM��0�./PX1�!,)])����X]��cӬ����qk���i���Z��b9�tl?�N$=��������4t��^�b��x)�k�����/E_�&�m\��dJ���.R;��U��N�8�Y$��3�r�o?;j�M��A0�g��P�}���Q�(���&*)1�۹��L�h���SH �F0X���z�Y8%�/~��\0B�̩��7��	-�[����˭l�r�Cc�� ����xtD՚5Q�X1dJ3���<n�؅��Y���ޓ?&�J�l
��A��`$���Ă��Ø!o,g�i�څ���FLa�Z?>�څLُ ĺ�ڝX�7*U�'�\]�G���z/?�ܬ\2~����A����q�!��G�i�y���
�'�ߒf�ff���7�e��lL�M���T�ټs�F��y���kת9��M�U���u��]�
!Fx��@E��o��%j�����M�6��c3E������� ��A�;�bcЇ��v�z(S�<��i��t�#ǏGP�0�_�����g�Z�_�N��0����A�ZA������`����D����@<A��$����~��ޓ���T-�p�����'-���Q�c�A-\Z����ΝͷZ!��j���&�#�&�#�П'��?�[�~}W��j�ÄU�\H�f��=^^^hۨ�� "���Mn�x� 򭿄F��(��Uƕ{7�4aH�C3AS�'�RM������m�v��, �.]i��l���kTW���)���e����0�M����w#14@��VZ�d���\ ���lοf/�i.��,�B�prNqm0I��7`�1�8=ь�?'P�
��ҝL�xS��^���8d�Z9�{��ߴ����m+�3�?L¤݌@Z�lY�Z�#ضn��; =vђw���۷)��o�M]��4v��u]D��=}�jj5m�Tt���-[����P�������;�Aw[�d�. c�WC����0���a~���)�<<ф�C�A�CS�Wǎ����V�F�����o�e+VD[w7�^�)c� 0|(X��ܻ�-�w����K�ғAc/��!����%" ��c�����V-q:��q���(��ha���Yi��X}��)��;�ʶ-����-XH�D�
C����o_�AkF���Y�����V.!I��S&�o�@�l��Z9�e�:�fc�*$_-�wk����sЫ�F��0�-��� �ik&�{�|�f��M�$�QG!!��w����7��vp;\�f�(SÙmϠ����(���B1$,��`��]�p�7�@����o{��	AV�%���-f�ee���^B�AiFBHֽ���`B��0J���oc�YmZ�2-���>����W��24�Z�X�KLi�����S�1a�1.TX9>f1���E��сV߮a�,ZD]ML.-#���o����l�����P����9��Z��+-eڷ��O���э�xc�ccGGԨY�ƍ�/�F��C+V�����"}�x��E�1,1+������TC�$/�H�Ѽ@�͛B0C�ZGh�n�����K��*��F"0!UC�����*��ό�8��H���Ǖ�.74�,�\A.��������t����|�J��
bKѸa��ZHgI֕ɞS��ƼD]P�߱k=�k�[�"Z �]����0㧖~��C�:���`�����Dи���=�hQ��������6�� ��(Q�d��?
���D�*0X�_h|C5L_� ���_+'t��&W�����z祼C IV�/`1k��%�.�'Y���D[�4�'t,�*����]py�v�a¶n�"�ATa��Qt�@�%�"i���,=
�.�:��X�u'3`�2ՅLZզ����r����6wB�2�HH|U���z�oL�[i+��|I�$�[H�7�=�/�G�(F�9�ƽ/�#&9M�8�qcE�=?��}cT�\66��kx�r���â�|íL�rK'L��q�3U�/ ?�C�1(8HM�ر�g�ؘ����^ ��l���\.��������}�Pއ�z��g�5v�p1���u�ĥMqf�.�%���O��i�0��7��2�DΔ)�K�-����0[�Koa9_O ##��4�N��V��������U������tw_W��Mu�w��G��Ū}��Ob}�.���h��髇�������ѫ���߸	�Iz�z���֪a���a#{�ߖ,Y���,��ի���`���R�������)�c�B�Н[����/�7H��ZD�1X]S�>��XF�Q�	@ � �L��h�J�g\ڲǙ�/�^�$27c"rX6�%��'hm�H�E "�)��4�Ν6�(��3f`�t%�㌑i�ף���@G�/\�6�Z�I'�z��!�n��{g+m���F��Ś%���	�r��UBD ���Kb8P�hDc�������R��+��/^��W��F�!$�o���g�}��h���I�e8�]�

���@5g�d�F̘;��lT.��_DAZ�&�j�tS�4H���S��mi���u��k�ߦ@H2�;�I`z7�;�m;VHKyZ�{!�N��è�����1c���I.!�,�S��p�+�f���q�Z��q�V�P��{���id�����Y�Q@!���v�8�}KZb�fVG��,����J��-_��ԯ�F����!A��z��[;w��C�B�^@~��� �!?+K�b�U۝�ͪG�=r����HS�n@
 ��F��W���~/�?\�A�-[��I�<��\�0_@Bh�"��|�t���i\�G��K@d�}1��hC�ۊYvG�^��j-�,�.GHk�Z���,�F�K�/��������.�n�:i]��T��J��[+̻pu�6F�
Q�n}�3�o�C�7i������woݺ]��&�bŋ���{�8�����0d�P�۸9��o��.��' �V�"04O���sd�ck�@��@��R�X�; 'X�oc�6wb��g�GWO�O7?�n>�� �1�-Q��\
!����� ��Y�O��ǰ�rk�����������fj-������������O:y川5��:�j�R��:DC?b��SQ�TQ���hR���Dߜ�+X�;)�V���o�� ��M�ѧO����[�6��I�ϊ|A�f�����a���ZN�d�&d���E�T$I��}rG�"���^}S4� �e����)�` ���1e�`Ch .�܆��Y��y��bw!���u�� J�G�H3	���\_(64��ph� ����U������oHa7&�:��j+�j�@�G�1�.oh7_Q?�&^QOY]4�Ԫj�P���)�Jx(����"�%��Ґ�.�}��خY���d� ��=qww��ү�z+V��M�������k�����/R�r�`��k�J��>�=(�����3�#���Ⱦ�(ʢ��Ⱦ�k�h�1Ѩ������$59�Ǔ>��5M�4�k�&M������^s�>����}���5I5���9���#������w����BV3��nb��$bJ3Y[��Vi	w�LX�
9����8�(<������e#�v����9��Y�;Q�wmf#�v����@$d� {6�(��J��A�O��C$��~>H��
�ȅ�Ϯe����<h+RRSgh�����ȑ��7��;1���k�-��`�eW�y�Ť�hI1���O���r�$0q�xy���t�eH��B𯘛~>jyU�+�}�~���(*���j$�r����N$� �%���a���tS�ɦ�±cp?j��vmm�Ѷ6ل�'�,&�m�h�(�F�����5P���>"�0����.�A���Y�'���_�Q���8�R�~ut&������[�uA>�B@������q�g���n�@T��:;^��8��)v�M�>�Q	"M�Ax��?o���+-}��~3�I�	���J(�\���`߉c�m�P�7�eKD<@]�i��Z;^�M����{ۜ9��1�н���p�i9<;>���Gh 4��Lh>0�ڵ(-�Q�L��G�qD|M�q�K

 A�Q� S
I�N��f�r� qv.�8��[2�_�mx�VLg�
�/�<���-�5��iq��� �kPV��?a-�J_'.dC=�ܹ���o^g���t��wh(�,�/��{�rG-�Y�Ws�ϵ��_��J�cx�>y�7�@����<�x�:f���v�_�姾84Z�K1A�o����{�0�;	G��o��q�;P��3����:��y�n��U�`��	���
�C鬫�ڢ"H>�OS�xz`ϫ�|*�TO��(���i6��C�ߥ�o�4Ȫz���ר�m��/��j蹇�::?��=�fI��Gsa����K�ԏ�r�5?;{P�-��2�~"@I� s��[aZ��U+!�ފ��K�&���\KX�ж�! ����?��
ό��CCL�7�^���- N�`��"��� 1�{kjj =!���05����Z�@�dϊ_ޠ.�ڕ�9��\n�w�j���0޼��z�/u~T�oc\������-*z8�_'��LI���s'g����Y�B��_���~���@9�>�w���QhYV��i�~�-��*VZ�kK6[�S)��Ȅ��_w8���<�ʑ֏��ok��|?�f�MD@�����TU�߃Q}3��Y�ɠ	�4�Y��Y������^4oHE���J͝)�������ʀ_i�J3����L���&x㏟���1V�EZ��H�g1 �@���_}��|��|i���q�_����/�� ��b!#@Qy9Tb��q�n;|4W�A��
J�[g�+{�Ҁ�i0�ȵ�Ռ �����6xz�N؍`��C_
>���� �����	��h��23!S�Yh�P�`s?���Ϸ�vJQ*	x�^�������u:�Ѳ^���q� ��Β��V�ct	Taagp𥕜��fn���O�痕�c��)�c��ê�r�F,��U;4m,}o��������h��V����3��&��~q���IЏ��H$��ގ�Wfe�#{
��Q�]�!l:�$?&<�������v��+���4���F��w����l_^�m>]�p��4�����ƈ?���	-�����;�X M�������VAI��ɴ��/(+e(D�+*�����l=p74-����"ʡ� ����6��
l	���p�&b ��֏҇�Ӌ҃ҍ҅n�����z��m�XW\�11�	��g�D�>�m�H�R�+�y"�+�<j�&��r���F3੡��X9���ʗ󚁿e�P7����`����oR��D��c�˞��%S
>-w��Ғ7L�����O(E))�\$@v~�``ػ}lڿ�;Z���	2��v�"[�!��=�P8;4���:���G�C�%���A���hm���]��599���A��$��@��7D[[��z;�CG�vd�c�L<i�_#�y��x�	��{��Pa�2��I���� ^�ӧ���}��\?j�
9��;��_M5�����g@��x���	�/�<�ļb$@a#@vA> a�e�6#	z6�BIh x[Z2"��[¦H<�����a;��!��rAm'DM@r��[X��!?-���'��A6����ȡ �v�h�nQK�D$@���_&�|���ˁ7��$�U���� Y&�V��-'}��qͬ0x��3p��CצM��1p��	09	����6m�b�q7Yz�����P(��ڟ��vna1� ��� +?2�r!;/������[G!Ѡ�X+K�G�c�=� ��y�C�Aҋ��'��Q���"����=��g!��N�����$u��`{��0�R.����a��%-�@_)^��'�"�LT�Ԉ���j�����ꛗ���ނz�itzS#�Gh/�+7��f��ٳ��0�~���"�)(d���	� ;��:������mP��KR����6s�U����B7IA�����,�;|���05�uwŀn/Œ�y����"�K���s8>����,�s�S;hp�J�Q��� WrY*���ȷJ��/�v������Cx��y��u�7&� ����+n��a*�����I�$ӏ�����I� ��D�l(�����߸���0Z�^�l��n��G�k��!#{��|�LO��4��;��f9��S�g�ѣ�۸Ԝ1I���ホHht�1���Qە|��N.C��Z��8�J���0X�/��2{�����0;��s��<��3�3'@�F��B��j|�Պ6zr�K�$��5?	�� ��'�Ir0M�F�}����������ϛ�(�(�P֦�BmB�U�A��)�~���z+����bYY�kb�FN�(ʠ��uB��ގ:��m�鬂���+'�N*�Rr��)8��'�XH�t��)ǯK,aU�9~~��'��\`�Tl��X�;A�(�d$�C�Ri�j\�����v`��������F�@6�M9��CC0��������(](�(m�����!�E����>��f+�YP�c���=]�b������L>��ŉ��Ξ�+��f���Ѩ��jA�
��T�˪w�rDá][�����6��
��)Ƴ�Hq��6uh/?�X�-�d�Q�|�ة��{-$�ʜA 2�9�F���c�~����c/~��fڏҎҌ>�$6�x��?䡿Ort@�-Y�������ۛ�b��N��dׯɿ�v�B)�xa  
'IDAT�z4��t�������K���^m<��%�E�^�6��������������07ch"�X�6s���ᓑ`B���S�@���|����Z�:]	��?K��P������p���Z�z1��D�'����סe�NN�Y��L�s1�ω�?^p�b^�����ә懊 O�śo;Qy[!*o�W���6����9"A�'T���̼��La� T� ������%�|�Ax���9Y���z�&R&Zа��(K � ��:������T�wS���obڂ�73ss�c��蝠2,4�=�ua�H��P�����Sd����P�U�����	>aT �]�b�<��dI�>ǎߵ#�������B�6�T�6��O��
&�)V(����*_Wh�H�Cc[�¥W�����MR;��O��D+�a%\��N��������~�������-0?+빑U��>�©�����m@+��s�\��sBB sz��x�����+�σ����EPk4`HN���ȫX��PY^5i�P��
%�,@���5R)���Ki�Hی�ݞgtPDD� r��=4�0����s^�_}������ĳg��휴tf�5B�#�t� rhD!'U�4�|�
_�����j�n�:��1���C��-٧��J��s1��@�����L��H''�F�]���{��̙����d�5�#	b�gC&j����6<v����aϡ�w�]���Fꫠ=>�ԫ�����YC���};����W9M�JO�R�ACj<tV�A��J�(/�գ���Oó��/��<uZ�a>�1�R7R��'њ�`rp00+�������6�ݒ�,1Q����#'6o�j[StUVB��E���bZ75�
���P�!�VVV�Hu�����C���}*��@�K}q��ś7?*�.�u}}pǽ��S�������Wg���^�g��¾~��W/�/��/���~��}���;��g�������G�`y-h��A���S6
�t:�*]#	�	$+ 	���콬�O�U`P��vvv.S��-Y�9=�ۻ�Hg痛��`P�9}bx�UCp�%�ї�0*���7������`goO����
����R&j�D�cg'&�!�T6%u^��M���lv�؀q�<��2
�{w��#�Xg�{>	�>��������y���u�ry=䗗A
f"z���-<B.�00c����
WN �r���~&,\󮫫[�Tct����T�gFG�=�����CͶ�h�F|U~�&0�[��<����.j�U//o��$���o:Z_��*�dF�;��1��1�O�,!]o�"@6F��͓F����j�J]5鳈L���ﮥ��;z^�Äo̐Ƈ`PJ։.b��,ux������"���������N���r�W]�;���9x����.��%��}%;,읦���8�2��Ғn��ZZZ�*����7���� ���0��ѩ6.���x!>)�i�|�|@Mʞ� s�ʖ ?C�I��b�A��	�Ll�������`v)��ښ�A!�t�X@����G�D��P��H�͍�o���:=:�ĽMMW���?���Ԭ�n�tq�QXZҞ�l���B��iӦ庹�S�) 0�
]��%S/4>	3� �`M6�.&K�"��j� D j����{��ѬD ���M��p�x��:,<�m����n�¦*�Y-�32h�D�����)�Xc��^�m�xf{m���jBPПWEEݻ,  ��ښL^(
i@�' I
J
�zy���D�+����-]zd?�k:��}�^\�	�y��a.I����I@$�, ��L�bd�����{"����H�Df:��}�>3cƌj�1�mmm�'���k���:U����������H����������B�?E�BS�}P(6:�kpCs��y��+������H��\���Ǭ�Z�� �4��7 �����	dn�V�@�3�a�����~���~���x�h���t���g���������h4�i��.6��(]U�C	C����ND �}����}>�ZMd�&����Gp������ߊ s8X�eA�XY'��D_�
�M� �:<�y7w���y�ڿ�?���;��qq]f�c��������%jPDϽP�,8�D�`��T�r]�'[H�Y�F1.��_(WL\@ڍ	@.��(�dq@��&�k18�;��ټ��3�a�Z���]Z{:;��57:���5�R����`�A&��'���*^������\R��ޟ�2�et����<�ʃ@>F���x�
�2�b&�@�N�74�o��a�����ѯ+
���?�5���~����p|�z���?h��BfX�$௵�J����OBHHhF�cbcJHLz&)9����)$���51%�K$�$����W� �1��>6�s]t���_@�f"�||�ڽ��3�mmm��u�w���u���D �H@��Φ�f.��(.�66��ex����Y�X[��xa�����7y�2M��n������n���Z��R��jA    IEND�B`�L�'sז	   �lN��X"   res://AverageTime/AverageTime.tscn ���h�p"   res://RouteFinder/RouteFinder.tscn$����{$   res://SegmentTimer/SegmentTimer.tscn
*o>��y   res://default_env.tresG����V+   res://icon.png�zs̥i    res://index.apple-touch-icon.png��,T�f   res://index.icon.pngh�`��8�	   res://index.png��~�Y2~   res://Main.tscn$ECFG      application/config/name      
   Prime Tool     application/run/main_scene         res://Main.tscn    application/config/features   "         4.0 "   application/run/low_processor_mode            application/config/icon         res://icon.png  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      �   *   editor/version_control_autoload_on_startup         "   editor/version_control_plugin_name         GitAPI  +   gui/common/drop_mouse_on_gui_input_disabled         )   physics/common/enable_pause_aware_picking         2   rendering/environment/defaults/default_environment          res://default_env.tres  rTܥ���?