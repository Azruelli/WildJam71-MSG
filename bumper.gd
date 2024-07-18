extends Area3D

@export var bump_force: float = 5.0

func bump() -> void:
	var bodies = get_overlapping_bodies()
	var bombs = get_tree().get_nodes_in_group("bomb")
	for bomb in bodies:
		if bomb.is_in_group("bomb") and bomb is RigidBody3D:
			var direction = (bomb.global_position - global_position).normalized()
			bomb.apply_impulse(direction * bump_force)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	bump()
