class_name Ship extends RigidBody3D

const SPEED: float = 1

func _process(delta: float) -> void:
	apply_central_force(Vector3.FORWARD * SPEED)
