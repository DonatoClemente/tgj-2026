extends Node

signal next_scene(scene_path: String)
signal reload

func load_next(scene_path: String):
	next_scene.emit(scene_path)

func reload_current_scene():
	reload.emit()
