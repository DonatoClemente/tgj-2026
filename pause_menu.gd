extends CanvasLayer

@export_file("*.tscn") var main_menu_scene: String

@onready var retry_btn: TextureButton = %RetryButton
@onready var main_menu_btn: TextureButton = %MenuButton
@onready var settings_btn: TextureButton = %SettingsButton
@onready var close_btn: TextureButton = %CloseButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
	settings_btn.pressed.connect(handle_settings)
	close_btn.pressed.connect(handle_close)
	retry_btn.pressed.connect(handle_retry)
	main_menu_btn.pressed.connect(handle_main_menu)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and Input.is_action_just_pressed("ui_cancel"):
		show()
		get_tree().paused = true

func handle_settings():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	$Settings.show()

func handle_close():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	hide()
	get_tree().paused = false

func handle_retry():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	Scene.reload_current_scene()
	get_tree().paused = false

func handle_main_menu():
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	Scene.load_next(main_menu_scene)
	get_tree().paused = false
