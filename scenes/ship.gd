class_name Ship extends CharacterBody3D

const SPEED = 1

func _process(delta: float) -> void:
	velocity = Vector3.FORWARD * SPEED
	move_and_slide()
