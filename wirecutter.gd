extends Area2D


@export var destination: Vector2
@export var duration: float = 7.0

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_speed_scale(30)
	tween.tween_interval(60)
	tween.tween_property(self, "global_position", global_position + destination, duration)
	tween.tween_interval(15 )
	tween.tween_property(self, "global_position", global_position, duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
