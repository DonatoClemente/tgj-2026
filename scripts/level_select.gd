extends CanvasLayer

@export_file("*.tscn") var main_menu: String
@export_file("*.tscn") var levels: Array[String]

@onready var lvl_one_btn: TextureButton = $Control/ColorRect/CenterContainer/GridContainer/LevelOne/LevelOneButton
@onready var lvl_two_btn: TextureButton = $Control/ColorRect/CenterContainer/GridContainer/LevelTwo/LevelTwoButton
@onready var lvl_three_btn: TextureButton = $Control/ColorRect/CenterContainer/GridContainer/LevelThree/LevelThreeButton

@onready var buttons: Array[TextureButton] = [
	lvl_one_btn,
	lvl_two_btn,
	lvl_three_btn
]

@onready var back_btn: Button = $Control/ColorRect/BackButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_btn.pressed.connect(func(): Scene.load_next(main_menu))
	if buttons.size() < 1:
		push_error("No level buttons in buttons array")
	for i in range(buttons.size()):
		if i > levels.size():
			push_error("More level buttons defined in buttons array than levels in levels array")
		buttons[i].pressed.connect(func(): Scene.load_next(levels[i]))
