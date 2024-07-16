extends AnimatableBody3D

@export var destination: Vector3
@export var duration: float = 10.0

func _ready() -> void:
	var tween = create_tween()
	tween.set_speed_scale(10)
	tween.tween_property(self, "global_position", global_position + destination, duration)
	tween.tween_property(self, "global_position", global_position, duration)
