extends Node

var music_vol = 0.7
var sfx_vol = 0.7

var music_mult = 0.5
var sfx_mult = 1.0

signal music_vol_changed(value: float)
signal sfx_vol_changed(value: float)

func _ready() -> void:
	music_vol_changed.connect(func(value: float): music_vol = value)
	sfx_vol_changed.connect(func(value: float): sfx_vol = value)
