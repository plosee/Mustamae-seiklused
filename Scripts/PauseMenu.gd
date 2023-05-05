extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("menu"):	
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	
	if is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_Resume_pressed():
	self.is_paused = false

func _on_Exit_To_Desktop_pressed():
	get_tree().quit()

func _on_Exit_To_Main_Menu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Main.tscn")
	self.is_paused = false
	
func _on_Feedback_pressed():
	OS.shell_open("https://docs.google.com/forms/d/e/1FAIpQLSdJ2to7RImhio26rf8qd2msbGVONk16Yy1xCmZ2Pfkg7mH_Aw/viewform?usp=sharing")
