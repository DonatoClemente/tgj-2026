extends CanvasLayer

@export_file("*.tscn") var main_menu: String
@export var parent: Node

@onready var retry_btn: TextureButton = %RetryButton
@onready var back_btn: TextureButton = %BackButton
@onready var quit_btn: TextureButton = %QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if parent == null:
		parent = get_parent()
	retry_btn.pressed.connect(handle_retry)
	back_btn.pressed.connect(handle_main_menu)
	quit_btn.pressed.connect(handle_quit)
	Data.died.connect(handle_show)

func handle_retry():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	Scene.reload_current_scene()

func handle_main_menu():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	Scene.load_next(main_menu)

func handle_quit():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	get_tree().quit()

func handle_show():
	show()
	$AudioStreamPlayer.play()
