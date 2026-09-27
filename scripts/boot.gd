extends Node2D

@export var triggered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not triggered:
		$Timer.timeout.connect(trigger)

func trigger():
	$AnimationPlayer.play("kick")
