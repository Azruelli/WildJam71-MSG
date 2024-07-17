extends StaticBody3D

var health = 1

func die() -> void:
	if health <= 0:
		queue_free()
func _process(delta: float) -> void:
	die()
