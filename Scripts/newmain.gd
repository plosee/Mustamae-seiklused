extends Control

var versnr = RandomNumberGenerator.new()
#IF YOU PUSH AN UPDATE TO LIVE CHANGE THIS TO TODAY'S DATE (DD.MM.YY) ALONG WITH update.txt
var versdate = "31.05.23"
var updateurl = "https://liivakast.hkhk.edu.ee/~mlaane/download/update.txt"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#DELETE AFTER EXE BECOMES MAIN BUILD or mommi fixes his crashing thing
	if !((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN)):
		$VideoStreamPlayer/HTMLpopup.popup()

	#CHECK FOR UPDATE CODE
func _on_Update_pressed():
	$VideoStreamPlayer/Update/HTTPRequest.request(updateurl)
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var output = body.get_string_from_utf8()
	if output != versdate:
		$VideoStreamPlayer/UpdatePopup.popup()
	else:
		$VideoStreamPlayer/Update.text = "Latest Version"
func _on_YesUpdate_pressed():
	OS.shell_open("https://plose.itch.io/mustamagi")
func _on_NoUpdate_pressed():
	$VideoStreamPlayer/UpdatePopup.hide()

	


func _physics_process(delta):
	var ver1 = versnr.randi_range(0,9)
	versnr.randomize()
	var ver2 = versnr.randi_range(0,9)
	versnr.randomize()
	var ver3 = versnr.randi_range(0,9)
	$Version.text = "Version Alpha " + str(ver1) + "." + str(ver2) + str(ver3)
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Build.tscn")

func _on_settings_pressed():
	$SettingsMenu.popup()

func _on_quit_pressed():
	get_tree().quit()

func _on_VideoPlayer_finished():
	$VideoStreamPlayer.play()


func _on_CheckButton_toggled(button_pressed):
	$AudioStreamPlayer.playing = button_pressed

func _on_Button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

func _on_Confirm_pressed():
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (true) else Window.MODE_WINDOWED
	$VideoStreamPlayer/HTMLpopup.hide()
func _on_Nah_pressed():
	$VideoStreamPlayer/HTMLpopup.hide()
