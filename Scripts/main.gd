extends Control

func _ready():
	pass
	
func _on_Seikleme_pressed():
	get_tree().change_scene("res://Scenes/Build.tscn")
	
func _on_Kohila_pressed():
	get_tree().change_scene("res://Scenes/credits.tscn")
