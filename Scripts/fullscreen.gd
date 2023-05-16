extends Button

var fs: Texture = preload("res://Images/fullscreen.png")
var ufs: Texture = preload("res://Images/unfullscreen.png")

func _ready():
	OS.window_fullscreen = Global.fullscreen

func _on_fullscreen_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen
	
	if Global.fullscreen:
		self.icon = fs
	else:
		self.icon = ufs
