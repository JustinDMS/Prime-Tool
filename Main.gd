extends Node

func _on_TabContainer_tab_selected(tab):
	
	match tab:
		0:
			OS.set_window_size(Vector2(400, 220))
		1:
			get_node("TabContainer/Average Time").updateWindowSize()
		2:
			get_node("TabContainer/Route Finder").adjustWindowSize()
