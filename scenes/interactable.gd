class_name Interactable extends Node3D

@export var visual_meshes: Array[MeshInstance3D] = []

const HIGHLIGHT_MATERIAL = preload("uid://jftme3ma5gbq")

func _ready() -> void:
	highlight(false)


func highlight(status: bool):
	for mesh_instance in visual_meshes:
		if status:
			mesh_instance.material_overlay = HIGHLIGHT_MATERIAL
		else:
			mesh_instance.material_overlay = null
