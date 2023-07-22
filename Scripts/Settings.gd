extends Control

@onready var mastervol = $static/SettingsVbox/MasterSlider.value
@onready var sfxvol = $static/SettingsVbox/SFXSlider.value
@onready var musicvol = $static/SettingsVbox/MusicSlider.value
var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")
var fpscap = false

func _ready():
	pass

func _process(delta):
	pass


func _on_static_finished():
	$static.play()



func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus,


