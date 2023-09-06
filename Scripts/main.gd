extends Control

var versnr = RandomNumberGenerator.new()
#IF YOU PUSH AN UPDATE TO LIVE CHANGE THIS TO TODAY'S DATE (DD.MM.YY) ALONG WITH update.txt
var versdate = "Godot4"
var updateurl = "https://liivakast.hkhk.edu.ee/~mlaane/download/update.txt"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Buttons/Update/UpdateBG.hide()
	$SettingsNode.hide()

func _process(delta):
	pass
	
func _on_bg_finished():
	if !$SettingsNode.visible:
		$BG.play()
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/loadingscreen.tscn")

func _on_settings_pressed():
	$SettingsNode.show()

func _on_quit_pressed():
	get_tree().quit()


#update function currently broken
func _on_update_pressed():
	$Buttons/Update/UpdateRequest.request(updateurl)
	print("requesting")
func _on_update_request_request_completed(result, response_code, headers, body):
	print(result, response_code,body)
	var output = body.get_string_from_utf8()
	print(output)
	if output != versdate:
		$Buttons/Update/UpdateBG.show()
	else:
		$Buttons/Update.text = "Latest Version"
func _on_yeah_pressed():
	OS.shell_open("https://plose.itch.io/mustamagi")
func _on_nah_pressed():
	$Buttons/Update/UpdateBG.hide()
	$Buttons/Update.text = "Update Recommended"
