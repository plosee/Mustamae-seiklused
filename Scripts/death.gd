extends ColorRect

func _physics_process(delta):
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
