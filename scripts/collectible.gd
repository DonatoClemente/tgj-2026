extends Node2D

@export var squeaks: Array[AudioStream]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(check_player)
	var squeak_track_index = randi_range(0,4)
	$AudioStreamPlayer2D.stream = squeaks[squeak_track_index]

func check_player(body: Node):
	if body.is_in_group("player"):
		$AudioStreamPlayer2D.play()
		$Sprite2D.hide()
		$Area2D.queue_free()
		await $AudioStreamPlayer2D.finished
		queue_free()
