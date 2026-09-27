extends Node2D


@export_file("*.tscn") var next_scene: String
@onready var start_btn: Button = %StartButton
@onready var settings_btn: Button = %SettingsButton
@onready var quit_btn: Button = %QuitButton
@onready var settings_panel: CanvasLayer = %Settings

func _ready() -> void:
	if Data.first_load:
		%Splash.play()
		Data.first_load = false
	start_btn.pressed.connect(btn_start)
	settings_btn.pressed.connect(btn_settings)
	quit_btn.pressed.connect(btn_quit)

func btn_start():
	Scene.load_next(next_scene)

func btn_settings():
	settings_panel.show()

func btn_quit():
	#Data.save()
	#await Data.finished
	get_tree().quit()
