extends RigidBody3D

var health = 1

func take_damate():
	pass

func _process(delta: float) -> void:
	if health == 0:
		queue_free()
