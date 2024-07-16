extends RigidBody3D

var health = 1

func _ready() -> void:
	add_to_group("Enemy")

func take_damage():
	pass

func _process(delta: float) -> void:
	if health == 0:
		queue_free()
