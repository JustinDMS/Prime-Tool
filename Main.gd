extends Node

func _on_TabContainer_tab_selected(tab):
	
	match tab:
		0:
			get_window().set_size(Vector2(450, 220))
		1:
			get_node("TabContainer/Average Time").updateWindowSize()
		2:
			get_node("TabContainer/Route Finder").adjustWindowSize()
