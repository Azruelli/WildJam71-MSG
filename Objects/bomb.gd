extends RigidBody3D
class_name Bomb

@onready var state_chart: StateChart = $StateChart

var health = 1

@export var explosion_center = Vector3.ZERO
@export var explosion_radius: float = 7.0
@export var explosion_force: float = 30.0
signal BombDamage
signal BombExplosion

var distance

func _on_ready():
	add_to_group("bomb")
	var piston = get_node("PistonZone")
	piston.on_body_entered.connect(body_entered)
	

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
				if entity.has_method("take damage"):
					entity.health -= 1

func damage_character(explosion_center: Vector3, explosion_radius: float):
	var damage_able = get_tree().get_nodes_in_group("character")
	
	for entity in damage_able:
		if entity.is_in_group("character"):
			var direction = entity.global_transform.origin - explosion_center
			var distance = direction.length()
			if distance < explosion_radius:
				
				entity.health -= 1

func damage_environment(explosion_center: Vector3, explosion_radius: float):
	var damage_able = get_tree().get_nodes_in_group("Enemy")
	
	for entity in damage_able:
		if entity.is_in_group("Enemy"):
			var direction = entity.global_transform.origin - explosion_center
			var distance = direction.length()
			if distance < explosion_radius:
				
				entity.health -= 1


#func explode_character(explosion_center: Vector3):
	#var force_targets = get_tree().get_nodes_in_group("phys_react")
	
	#for entity in force_targets:
		#if entity is CharacterBody3D:
			#var distance = explosion_center.distance_to(entity.global_transform.origin)
			
			#if distance <= explosion_radius:
				#var direction = (entity.global_transform.origin - explosion_center).normalized()
				#var force = direction * explosion_force / (distance + 1)
				
				#if entity.has_method("move_and_slide"):
					#entity.move_and_slide(force)

#func explode_character(explosion_center: Vector3, explosion_radius: float, explosion_force: float):
	#var force_targets = get_tree().get_nodes_in_group("phys-react")
	
	#for entity in force_targets:
		#if entity.is_in_group("phys_react") and entity is CharacterBody3D:
			#var character = entity as CharacterBody3D
			#var direction = entity.global_transform.origin - explosion_center
			#var distance = entity.distance_to(self.origin)
			#if distance < explosion_radius:
				#direction = direction.normalized()
				#var force_magnitude = (1.0 -(distance / explosion_radius)) * explosion_force
				
				#if entity.has_method("take_damage"):
					
				
				




func _on_timer_timeout() -> void:
	print("timed out")
	state_chart.send_event("explode")


func _on_explode_state_physics_processing(delta: float) -> void:
	explode(explosion_center, explosion_radius, explosion_force)
	damage_character(explosion_center, explosion_radius)
	#emit_signal("BombExplosion")
	#emit_signal("BombDamage")
	queue_free()


#func _on_push_pin_body_entered(body: Area3D) -> void:
	#if body is PushPin:
		#print("touched")
		#var body_direction = body.global_transform.origin - self.origin
		#var launch_direction = body_direction.inverse()
		#var true_launch_dir = launch_direction.normalized()
		#self.apply_impulse(true_launch_dir * 300)

func _on_piston_zone_body_entered(body: Node3D) -> void:
	if body is Bomb:
		body.health -= 1

func die() -> void:
	if health <= 0:
		queue_free()

func _on_lit_state_physics_processing(delta: float) -> void:
	die()
