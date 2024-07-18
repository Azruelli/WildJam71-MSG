extends Node3D

@onready var node_3d: Node3D = $".."
@onready var spawner: Node3D = $"."

@export var speed := 44.0
var bomb10s


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bomb10s = preload("res://Objects/bomb10s.tscn")




func _physics_process(delta: float) -> void:

	var weight = clamp(delta * speed, 0.0, 1.0)
	
	global_transform = global_transform.interpolate_with(
		get_parent().global_transform, weight
	)
	global_position = get_parent().global_position

func _on_timer_timeout() -> void:
	var world = get_tree().get_root()
	var instance = bomb10s.instantiate()
	add_child(
		instance
	)
