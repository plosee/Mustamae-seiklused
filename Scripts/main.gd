extends Control

var fullscreen = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Seikleme_pressed():
	get_tree().change_scene("res://Scenes/Build.tscn")
	
func _on_Kohila_pressed():
	get_tree().change_scene("res://Scenes/credits.tscn")
