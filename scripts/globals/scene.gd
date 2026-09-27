extends Node

signal next_scene(node: Node)

func load_next(scene_path: String):
	var scene = load(scene_path)
	if scene != null:
		var node = scene.instantiate()
		next_scene.emit(node)
