extends Node2D

var IMPULSE_FORCE = 50
@onready var boxes: Array[Node] = $Boxes.get_children()
var falling = false

func _ready() -> void:
	$Area2D.body_entered.connect(check_trigger_fall)
	for box in boxes as Array[RigidBody2D]:
		box.body_entered.connect(check_stop_fall)

func check_trigger_fall(body: Node):
	if not falling:
		if body.is_in_group("player") or body.is_in_group("ball"):
			falling = true
			for box in boxes as Array[RigidBody2D]:
				box.set_collision_mask_value(1, false)
				box.set_collision_mask_value(3, false)
				box.apply_impulse(Vector2(randf(),randf()) * IMPULSE_FORCE)

func check_stop_fall(body: Node):
	if body.is_in_group("false_floor"):
		for box in boxes as Array[RigidBody2D]:
			box.set_collision_mask_value(1, true)
			box.set_collision_mask_value(3, true)
