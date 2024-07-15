extends Camera3D

@export var speed := 44.0
@onready var player: Player = $"../.."
var deltaSuper = Engine.get_main_loop().root.get_physics_process_delta_time()

var parent_node: Node3D

func _ready() -> void:
	parent_node = get_parent()

func _physics_process(delta: float) -> void:
	#var weight = clamp(delta * speed, 0.0, 1.0)
	deltaSuper = get_physics_process_delta_time()
	look_at(player.global_position, Vector3.UP)
	
	if parent_node:
		var target_pos = parent_node.global_transform.origin
		var current_pos = global_transform.origin
		var update_pos = current_pos.lerp(target_pos, speed * deltaSuper)
	
		global_transform.origin = update_pos
		
	
	#global_transform = global_transform.interpolate_with(
	#	get_parent().global_transform, weight
	#)
	#global_position = get_parent().global_position
