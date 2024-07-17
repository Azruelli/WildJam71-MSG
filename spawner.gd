extends Node3D

var bomb5s

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bomb5s = preload("res://Objects/bomb.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var world = get_tree().get_root()
	var instance = bomb5s.instantiate()
	add_child(
		instance
	)
