extends StaticBody2D

@export var triggered: bool = false

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#if not triggered:
		#$Area2D.body_entered.connect(check_boxes)

func trigger():
	queue_free()

#func check_boxes(body: Node):
	#if body.is_in_group("box"):
		#var timer = get_tree().create_timer(0.1)
		#await timer.timeout
		#trigger()
