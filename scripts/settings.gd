extends CanvasLayer

@onready var close_btn: Button = %Button

@onready var music_val: Label = %MusicValue
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_val: Label = %SFXValue
@onready var sfx_slider: HSlider = %SFXSlider

func _ready() -> void:
	# Load Music and SFX settings
	music_val.text = str(Audio.music_vol * 100)
	music_slider.value = Audio.music_vol
	sfx_val.text = str(Audio.sfx_vol * 100)
	sfx_slider.value = Audio.sfx_vol
	# Connect signals
	close_btn.pressed.connect(btn_close)
	music_slider.value_changed.connect(music_slider_change)
	sfx_slider.value_changed.connect(sfx_slider_change)

func btn_close():
	hide()

func music_slider_change(value: float):
	music_val.text = str(value * 100)
	Audio.music_vol_changed.emit(value)

func sfx_slider_change(value: float):
	sfx_val.text = str(value * 100)
	Audio.sfx_vol_changed.emit(value)
