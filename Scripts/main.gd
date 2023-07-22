extends Control

var versnr = RandomNumberGenerator.new()
#IF YOU PUSH AN UPDATE TO LIVE CHANGE THIS TO TODAY'S DATE (DD.MM.YY) ALONG WITH update.txt
var versdate = "31.05.23"
var updateurl = "https://liivakast.hkhk.edu.ee/~mlaane/download/update.txt"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Buttons/Update/UpdateBG.hide()
	

func _process(delta):
	pass
	
func _on_bg_finished():
	$BG.play()
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_settings_pressed():
	pass

func _on_quit_pressed():
	get_tree().quit()

#update function currently broken
func _on_update_pressed():
	$Buttons/Update/UpdateRequest.request(updateurl)
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var output = body.get_string_from_utf8()
	if output == versdate:
		$Buttons/Update/UpdateBG.show()
	else:
		$Buttons/Update.text = "Latest Version"
func _on_yeah_pressed():
	OS.shell_open("https://plose.itch.io/mustamagi")
func _on_nah_pressed():
	$Buttons/Update/UpdateBG.hide()
