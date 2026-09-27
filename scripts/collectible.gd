extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(check_player)

func check_player(body: Node):
	if body.is_in_group("player"):
		queue_free()
