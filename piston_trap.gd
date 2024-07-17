extends AnimatableBody3D

@export var destination: Vector3
@export var duration: float = 7.0

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_speed_scale(30)
	tween.tween_interval(60)
	tween.tween_property(self, "global_position", global_position + destination, duration)
	tween.tween_interval(15 )
	tween.tween_property(self, "global_position", global_position, duration)



func _on_area_3d_body_entered(body: Node3D) -> void:
	var damage_able = get_tree().get_nodes_in_group("character")
	
	for entity in damage_able:
		if entity.is_in_group("character") and entity is CharacterBody3D:
				entity.health -= 1
