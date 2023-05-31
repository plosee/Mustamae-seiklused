extends Control

var versnr = RandomNumberGenerator.new()
#IF YOU PUSH AN UPDATE TO LIVE CHANGE THIS TO TODAY'S DATE (DD.MM.YY) ALONG WITH update.txt
var versdate = "31.05.23"
var updateurl = "https://liivakast.hkhk.edu.ee/~mlaane/download/update.txt"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#DELETE AFTER EXE BECOMES MAIN BUILD or mommi fixes his crashing thing
	if !OS.window_fullscreen:
		$VideoPlayer/HTMLpopup.popup()

	#CHECK FOR UPDATE CODE
func _on_Update_pressed():
	$VideoPlayer/Update/HTTPRequest.request(updateurl)
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var output = body.get_string_from_utf8()
	if output != versdate:
		$VideoPlayer/UpdatePopup.popup()
	else:
		$VideoPlayer/Update.text = "Latest Version"
func _on_YesUpdate_pressed():
	OS.shell_open("https://plose.itch.io/mustamagi")
func _on_NoUpdate_pressed():
	$VideoPlayer/UpdatePopup.hide()

	


func _physics_process(delta):
	var ver1 = versnr.randi_range(0,9)
	versnr.randomize()
	var ver2 = versnr.randi_range(0,9)
	versnr.randomize()
	var ver3 = versnr.randi_range(0,9)
	$Version.bbcode_text = "Version Alpha " + str(ver1) + "." + str(ver2) + str(ver3)
	
func _on_start_pressed():
	get_tree().change_scene("res://Scenes/Build.tscn")

func _on_settings_pressed():
	$SettingsMenu.popup()

func _on_quit_pressed():
	get_tree().quit()

func _on_VideoPlayer_finished():
	$VideoPlayer.play()


func _on_CheckButton_toggled(button_pressed):
	$AudioStreamPlayer.playing = button_pressed

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/credits.tscn")

func _on_Confirm_pressed():
	OS.window_fullscreen = true
	$VideoPlayer/HTMLpopup.hide()
func _on_Nah_pressed():
	$VideoPlayer/HTMLpopup.hide()
