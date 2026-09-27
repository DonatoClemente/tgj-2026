extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_volume_db(linear_to_db(Audio.music_vol))
	Audio.music_vol_changed.connect(func(value: float): set_volume_db(linear_to_db(value)))
