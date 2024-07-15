extends AnimatableBody3D

class_name PushPin

@export var destination: Vector3
@export var duration: float = 0.01

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_speed_scale(600)
	tween.tween_property(self, "global_position", global_position + destination, duration)
	tween.tween_property(self, "global_position", global_position, duration)
