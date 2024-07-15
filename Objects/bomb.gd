extends RigidBody3D

@onready var state_chart: StateChart = $StateChart

@export var explosion_center = Vector3.ZERO
@export var explosion_radius = 3.0
@export var explosion_force = 30.0
signal BombDamage 

func _process(delta: float) -> void:
	pass

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
				



func explode_character(explosion_center: Vector3, explosion_radius: float, explosion_force: float):
	var force_targets = get_tree().get_nodes_in_group("phys-react")
	
	for entity in force_targets:
		if entity.is_in_group("phys_react") and entity is CharacterBody3D:
			var direction = entity.global_transform.origin - explosion_center
			var distance = direction.length()
			if distance < explosion_radius:
				direction = direction.normalized()
				var force_magnitude = (1.0 -(distance / explosion_radius)) * explosion_force
				
				entity.velocity.x = direction.x * force_magnitude * 100
				entity.velocity.z = direction.z * force_magnitude * 100
				entity.velocity.y = direction.y * force_magnitude * 100




func _on_timer_timeout() -> void:
	print("timed out")
	state_chart.send_event("explode")


func _on_explode_state_physics_processing(delta: float) -> void:
	explode(explosion_center, explosion_radius, explosion_force)


#func _on_push_pin_body_entered(body: Area3D) -> void:
	#if body is PushPin:
		#print("touched")
		#var body_direction = body.global_transform.origin - self.origin
		#var launch_direction = body_direction.inverse()
		#var true_launch_dir = launch_direction.normalized()
		#self.apply_impulse(true_launch_dir * 300)
