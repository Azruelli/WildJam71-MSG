extends Timer


@onready var timer: Timer = $"."

@export var timer_wait_time: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = timer_wait_time
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
