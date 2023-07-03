extends MeshInstance3D

const duration : float = 0.5

func _ready():
	var tween = get_tree().create_tween()
	tween.finished.connect(Callable(self, "queue_free"))
	tween.tween_property(self, "transparency", 1.0, duration).set_ease(Tween.EASE_OUT)
