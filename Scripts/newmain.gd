extends Control

var versnr = RandomNumberGenerator.new()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#DELETE AFTER EXE BECOMES MAIN BUILD or mommi fixes his crashing thing
	if !OS.window_fullscreen:
		$VideoPlayer/HTMLpopup.popup()
func _physics_process(delta):
	var ver1 = versnr.randi_range(0,9)
	versnr.randomize()
	var ver2 = versnr.randi_range(0,9)
	versnr.randomize()
	var ver3 = versnr.randi_range(0,9)
	$Version.bbcode_text = "Version Alpha " + str(ver1) + "." + str(ver2) + str(ver3)
	
func _on_start_pressed():
	get_tree().change_scene("res://Scenes/Build.tscn")


func _on_settings_pressed():
	$SettingsMenu.popup()

func _on_quit_pressed():
	get_tree().quit()

func _on_VideoPlayer_finished():
	$VideoPlayer.play()


func _on_CheckButton_toggled(button_pressed):
	$AudioStreamPlayer.playing = button_pressed

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/credits.tscn")

func _on_Confirm_pressed():
	OS.window_fullscreen = true
	$VideoPlayer/HTMLpopup.hide()
func _on_Nah_pressed():
	$VideoPlayer/HTMLpopup.hide()
