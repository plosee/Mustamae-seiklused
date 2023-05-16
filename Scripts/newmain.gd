extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_pressed():
	get_tree().change_scene("res://Scenes/Build.tscn")


func _on_settings_pressed():
	$SettingsMenu.popup()


func _on_quit_pressed():
	get_tree().quit()


func _on_fullscreen_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen


func _on_VideoPlayer_finished():
	$VideoPlayer.play()


func _on_CheckButton_toggled(button_pressed):
	$AudioStreamPlayer.playing = button_pressed

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/credits.tscn")
