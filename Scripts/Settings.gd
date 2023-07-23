extends Control

#var mastervol = $static/SettingsVbox/MasterSlider.value
#var sfxvol = $static/SettingsVbox/SFXSlider.value
#var musicvol = $static/SettingsVbox/MusicSlider.value
var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")

var fpscap = false
var showfps = false

func _ready():
	pass

func _process(delta):
	pass

#to loop bgv
func _on_static_finished():
	$static.play()

#mastervol
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func _on_limit_fps_pressed():
	fpscap = !fpscap
	if fpscap:
		$"static/SettingsVbox/Limit FPS".text = "Uncap FPS"
	else: 
		$"static/SettingsVbox/Limit FPS".text = "Cap FPS"

func _on_show_fps_pressed():
	showfps = !showfps
	if showfps:
		$"static/SettingsVbox/Show FPS".text = "Hide FPS"
	else:
		$"static/SettingsVbox/Show FPS".text = "Show FPS"
