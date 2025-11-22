class_name Space extends Node3D

const SPACE_CHUNK = preload("res://scenes/space_chunk.tscn")

func _ready() -> void:
	var spaceChunk = SPACE_CHUNK.instantiate()
	add_child(spaceChunk)
