extends CharacterBody3D
class_name Player

var health = 3

#Onready Variables
@onready var state_chart: StateChart = $StateChart
@onready var camera_mount: Node3D = $CameraMount


#proj stuff variables that are important to general function
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var deltaSuper : float = Engine.get_main_loop().root.get_physics_process_delta_time()

@export var player_speed: float = 10.0
@export var jump_velocity: float = 7.0

#mouse mode stuff
var mouse_motion := Vector2.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	handle_state()
	debugcommands()
	handle_camera_rotation()
	deltaSuper = get_physics_process_delta_time()
	print(health)

func walking() -> void:
	var input_dir := Input.get_vector("Left","Right","Forward","Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * player_speed, player_speed * deltaSuper * .5)
		velocity.z = lerp(velocity.z, direction.z * player_speed, player_speed * deltaSuper * .5)
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed * deltaSuper)
		velocity.z = move_toward(velocity.z, 0, player_speed * deltaSuper)
		
		

func take_damage(attack: Attack):
	pass

func debugcommands() -> void:
	if Input.is_action_just_pressed("ui_end"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("ui_home"):
		health = 0

func falling() -> void:
	velocity.y -=  gravity * deltaSuper

func jumping() -> void:
	if Input.is_action_just_pressed("Jump"):
		velocity.y = jump_velocity

func handle_state() -> void:
	if health <= 0:
		state_chart.send_event("die")
	if not Input.is_anything_pressed() and is_on_floor():
		state_chart.send_event("idle")
	if is_on_floor() and Input.is_anything_pressed():
		state_chart.send_event("ground")
	if not is_on_floor():
		state_chart.send_event("air")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * 0.001


func handle_camera_rotation() -> void:
	rotate_y(mouse_motion.x)
	camera_mount.rotate_x(mouse_motion.y)
	camera_mount.rotation_degrees.x = clampf(
		camera_mount.rotation_degrees.x, -90.0, 90.0
	)
	mouse_motion = Vector2.ZERO

#State Entries called every frame on existing state, each one of these takes an input function on delta
#which allows it to update outside of the main loop
func _on_grounded_state_physics_processing(delta: float) -> void:
	walking()

func _on_in_air_state_physics_processing(delta: float) -> void:
	falling()

func _on_idle_state_physics_processing(delta: float) -> void:
	falling()
	walking()

func _on_die_state_physics_processing(delta: float) -> void:
	falling()


func _on_bomb_bomb_damage() -> void:
	health = health - 1
