extends Node

@onready var tab_container = $TabContainer

var tab_sizes : Dictionary = {
	0 : Vector2(550, 200), # Segment Timer
	1 : Vector2(550, 200), # Average Time
	2 : Vector2(550, 650), # Route Finder
	3 : Vector2(550, 250), # Auto Timer
}


func _on_TabContainer_tab_selected(tab):
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_MAXIMIZED:
		get_window().set_size(tab_sizes[tab])
