class_name SpaceChunk extends Node3D

const CHUNK_SIZE: int = 64
const SPACE_OBJECT = preload("res://scenes/space_object.tscn")

var rng = RandomNumberGenerator. new()

func _ready() -> void:
	for x in range(-CHUNK_SIZE, CHUNK_SIZE):
		for y in range(-CHUNK_SIZE, CHUNK_SIZE):
			for z in range(-CHUNK_SIZE, CHUNK_SIZE):
				if rng.randi_range(0, 100) < 2:
					var space_object = SPACE_OBJECT.instantiate()
					add_child(space_object);
					space_object.position = Vector3(x,y,z)
