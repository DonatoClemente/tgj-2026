extends Node2D


@export_file("*.tscn") var next_scene: String
@onready var start_btn: TextureButton = %StartButton
@onready var settings_btn: TextureButton = %SettingsButton
@onready var quit_btn: TextureButton = %QuitButton
@onready var settings_panel: CanvasLayer = %Settings

func _ready() -> void:
	start_btn.pressed.connect(btn_start)
	settings_btn.pressed.connect(btn_settings)
	quit_btn.pressed.connect(btn_quit)

func btn_start():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	Scene.load_next(next_scene)

func btn_settings():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	settings_panel.show()

func btn_quit():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	#Data.save()
	#await Data.finished
	get_tree().quit()
