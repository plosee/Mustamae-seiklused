extends Control

var fullscreen = false

func _ready():
	pass
	
func _on_Seikleme_pressed():
	get_tree().change_scene("res://Scenes/Build.tscn")
	
func _on_Kohila_pressed():
	get_tree().change_scene("res://Scenes/credits.tscn")


func _on_fullscreen_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen
	fullscreen = true
