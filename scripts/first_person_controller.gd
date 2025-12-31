class_name FirstPersonController extends CharacterBody3D

@export var ship: RigidBody3D = null

@onready var camera: Camera3D = $Camera3D
@onready var ground_ray_cast: RayCast3D = $GroundRayCast
@onready var interact_ray_cast: RayCast3D = $Camera3D/FirstPersonRayCast

const SPEED: float = 10 # m/s
const ACCELERATION: float = 100 # m/s^2
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity_velocity: Vector3 = Vector3.ZERO
var walk_velocity: Vector3 = Vector3.ZERO

var looking_at: Interactable = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"exit"):
		get_tree().quit()
	elif event is InputEventMouseMotion:
		var look_dir = event.relative * 0.001
		camera.rotation.y -= look_dir.x
		camera.rotation.x = clamp(camera.rotation.x - look_dir.y, -1.5, 1.5)


func _physics_process(delta: float) -> void:
	_update_looking_at()
	_handle_first_person_movement(delta)

func _handle_first_person_movement(delta: float) -> void:
	var move_dir = Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backwards")
	var forward = camera.global_transform.basis * Vector3(move_dir.x, 0, move_dir.y)
	var walk_dir = Vector3(forward.x, 0, forward.z).normalized()
	walk_velocity = walk_velocity.move_toward(walk_dir * SPEED * move_dir.length(), ACCELERATION * delta)
	velocity = walk_velocity
	if ship.is_node_ready():
		velocity += ship.linear_velocity
	if ground_ray_cast.is_colliding() and ground_ray_cast.get_collision_point().distance_to(ground_ray_cast.global_position) > 0.2:
		gravity_velocity = gravity_velocity.move_toward(Vector3(0, velocity.y - gravity, 0), gravity * delta)
	else:
		gravity_velocity = Vector3.ZERO
	velocity += gravity_velocity
	move_and_slide()

func _update_looking_at() -> void:
	var collider = interact_ray_cast.get_collider()
	if interact_ray_cast.is_colliding() and collider is Interactable and is_instance_valid(collider):
		if is_instance_valid(looking_at) and looking_at != collider:
			looking_at.highlight(false)
		looking_at = collider
		looking_at.highlight(true)
	else:
		if is_instance_valid(looking_at):
			looking_at.highlight(false)
		looking_at = null
