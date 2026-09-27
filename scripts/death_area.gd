extends Area2D


func _ready() -> void:
	body_entered.connect(check_for_player)

func check_for_player(body: Node2D):
	if body.is_in_group("player"):
		body.die()
