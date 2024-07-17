extends RayCast3D

@onready var player: Player = $"../../.."


func _physics_process(delta: float) -> void:
	look_at(player.global_transform.origin, Vector3.UP)
