extends RigidBody3D

func _ready() -> void:
	var explosion_center = Vector3.ZERO
	var explosion_radius = 3.0
	var explosion_force = 30


func explode(explosion_center: Vector3, explosion_radius: float, explosion_force:float):
	var force_targets = get_tree().get_nodes_in_group("phys_react")
	
	for entity in force_targets:
		if entity.is_in_group("phys_react") and entity is RigidBody3D:
			
			var direction = entity.global_transform.origin - explosion_center
			var distance = direction.length()
			if distance < explosion_radius:
				direction = direction.normalized()
				var force_magnitude = (1.0 -(distance / explosion_radius)) * explosion_force
				
				entity.apply_impulse(direction * force_magnitude)
