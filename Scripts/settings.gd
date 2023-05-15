extends Popup

onready var mastervol = $VBoxContainer/Master
onready var sfxvol = $VBoxContainer/SFX
onready var musicvol = $VBoxContainer/Music



#func _ready():
#	popup()
func _physics_process(delta):
	$LabelContainer/MasterLabel.bbcode_text = "[center]Master Volume: [/center]" + str(int(mastervol.value)) + "%"
	$LabelContainer/SFXLabel.bbcode_text = "[center]SFX Volume: [/center]" + str(int(sfxvol.value)) + "%"
	$LabelContainer/MusicLabel.bbcode_text = "[center]Music Volume: [/center]" + str(int(musicvol.value)) + "%"

func _on_background_finished():
	$background.play()

func _on_fs_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
#onready var master_slider = 


func _on_back_pressed():
	self.hide()
