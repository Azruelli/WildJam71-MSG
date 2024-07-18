extends Node3D

@onready var node_3d: Node3D = $".."
@onready var spawner: Node3D = $"."

@export var speed := 44.0
var bomb20s


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bomb20s = preload("res://Objects/bomb20s.tscn")




func _physics_process(delta: float) -> void:

	var weight = clamp(delta * speed, 0.0, 1.0)
	


func _on_timer_timeout() -> void:
	var world = get_tree().get_root()
	var instance = bomb20s.instantiate()
	add_child(
		instance
	)
