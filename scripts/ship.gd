class_name Ship extends RigidBody3D

const SPEED: float = 1
var phys_frames_count: int = 0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var speed = sqrt(pow(linear_velocity.x, 2) + pow(linear_velocity.y, 2) + pow(linear_velocity.z, 2))
	if speed < 2:
		apply_central_impulse(Vector3.FORWARD * delta)
	
	if phys_frames_count == 100:
		print("Space ship speed: ", speed)
		phys_frames_count = 0
	
	phys_frames_count += 1
