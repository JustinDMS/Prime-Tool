extends Control

@onready var graph = $MarginContainer/Graph2D

var plot_item

func add_plot_item(label = "", color = Color.WHITE, width = 1.0):
	plot_item = graph.add_plot_item(label, color, width)

func setMax(_max : int) -> void:
	graph.set("x_max", _max)

func add_point(pt: Vector2) -> void:
	plot_item.add_point(pt)

func clear() -> void:
	plot_item.clear()
