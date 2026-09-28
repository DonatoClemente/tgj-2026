extends Node2D

@export_file("*.tscn") var main_menu: String

func _ready() -> void:
	play()

func play():
	$AnimationPlayer.play("splash")
	await $AnimationPlayer.animation_finished
	Scene.load_next(main_menu)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed("ui_accept"):
		Scene.load_next(main_menu)
