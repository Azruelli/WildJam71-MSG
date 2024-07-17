extends Node

var health = 3

func _ready() -> void:
	add_to_group("Enemy")

func die() -> void:
	if health <= 0:
		queue_free()
