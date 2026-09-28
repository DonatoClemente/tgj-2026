extends Area2D

@export_file("*.tscn") var next_scene: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(handle_exit)

func handle_exit(body: Node):
	if body.is_in_group("player"):
		$AudioStreamPlayer2D.play()
		if next_scene != null:
			var timer = get_tree().create_timer(1.5)
			await timer.timeout
			Scene.load_next(next_scene)
		else:
			push_error("No next scene from exit from")
