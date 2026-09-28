extends Node

var current_scene_path: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Scene.next_scene.connect(load_next_scene)
	Scene.reload.connect(reload_current_scene)

func load_next_scene(scene_path: String):
	var scene = load(scene_path)
	if scene != null:
		var node = scene.instantiate()
		for child in get_children():
			child.queue_free()
		add_child(node)
		current_scene_path = scene_path

func reload_current_scene():
	load_next_scene(current_scene_path)
