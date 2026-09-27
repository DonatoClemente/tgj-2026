extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Scene.next_scene.connect(load_next_scene)

func load_next_scene(node: Node):
	for child in get_children():
		child.queue_free()
	add_child(node)
