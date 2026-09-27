extends Node2D

@export var trigger_target: Node
@export var player_triggers: bool = true
@export var ball_triggers: bool = true
@export var box_triggers: bool = true

var pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(check_player_or_ball_or_box)

func check_player_or_ball_or_box(body: Node):
	if not pressed:
		if body.is_in_group("player") and player_triggers:
			trigger()
		if body.is_in_group("ball") and ball_triggers:
			trigger()
		if body.is_in_group("box") and box_triggers:
			trigger()

func trigger():
	if trigger_target != null:
		trigger_target.trigger()
	$Unpressed.hide()
	pressed = true
