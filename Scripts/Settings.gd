extends Popup

#var mastervol = $static/SettingsVbox/MasterSlider.value
#var sfxvol = $static/SettingsVbox/SFXSlider.value
#var musicvol = $static/SettingsVbox/MusicSlider.value
var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")

var fullscreen = true
var fpscap = false
var showfps = false

func _ready():
	self.hide()
	
	
func _process(delta):
	if self.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
	else:
		get_tree().paused = false
		
	
#to loop bgv
func _on_static_finished():
	$static.play()


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


func _on_fullscreen_pressed():
	fullscreen = !fullscreen
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#Audio Buses
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
		
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus,value)
	if value == -30:
		AudioServer.set_bus_mute(music_bus, true)
	else:
		AudioServer.set_bus_mute(music_bus, false)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus,value)
	if value == -30:
		AudioServer.set_bus_mute(sfx_bus, true)
	else:
		AudioServer.set_bus_mute(sfx_bus, false)


func _on_inventory_pause():
	self.show()

func _on_back_pressed():
	self.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

