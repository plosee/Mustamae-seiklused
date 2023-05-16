extends Popup

#onready var global = get_node("res://Scripts/Global.gd")

onready var mastervol = $VBoxContainer/Master
onready var sfxvol = $VBoxContainer/SFX
onready var musicvol = $VBoxContainer/Music
var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")

#func _ready():
#	popup()
#func _physics_process(delta):
#	print(Global.showfps)

func _on_background_finished():
	$background.play()

func _on_fs_pressed():
	Global.fullscreen = !Global.fullscreen
	OS.window_fullscreen = Global.fullscreen

func _on_back_pressed():
	self.hide()

func _on_Master_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func _on_SFX_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(sfx_bus, true)
	else:
		AudioServer.set_bus_mute(sfx_bus, false)

func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(music_bus, true)
	else:
		AudioServer.set_bus_mute(music_bus, false)

func _on_FPS_pressed():
	Global.showfps = !Global.showfps
	if Global.showfps:
		$VBoxContainer/FPS.text = "Hide FPS"
	else:
		$VBoxContainer/FPS.text = "Show FPS"
