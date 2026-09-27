extends RigidBody2D

@onready var area: Area2D = $Area2D

func _ready() -> void:
	area.body_entered.connect(check_player_entered)
	#area.body_exited.connect(check_player_exited)

func check_player_entered(body: Node):
	if body.is_in_group("player"):
		body.push_velocity.x = linear_velocity.x

#func check_player_exited(body: Node):
	#if body.is_in_group("player"):
