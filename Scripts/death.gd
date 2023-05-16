extends ColorRect

func _physics_process(delta):
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://Scenes/Main.tscn")
