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
