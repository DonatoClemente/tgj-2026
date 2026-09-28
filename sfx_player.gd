extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_volume_db(linear_to_db(Audio.sfx_vol * Audio.sfx_mult))
	Audio.sfx_vol_changed.connect(func(value: float): set_volume_db(linear_to_db(value * Audio.sfx_mult)))
	Data.died.connect(func(): stop())
	print(volume_linear)
