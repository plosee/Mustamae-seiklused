extends Button

var fs: Texture2D = preload("res://Images/fullscreen.png")
var ufs: Texture2D = preload("res://Images/unfullscreen.png")

func _ready():
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (Global.fullscreen) else Window.MODE_WINDOWED

func _on_fullscreen_toggled(button_pressed):
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (!((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED
	
	if Global.fullscreen:
		self.icon = fs
	else:
		self.icon = ufs
