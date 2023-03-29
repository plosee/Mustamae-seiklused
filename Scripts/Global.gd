extends Node

var in_cutscene = false
var current_cutscene = 0
func _ready():
	pass
	
func _process(delta):
	if current_cutscene > 0:
		in_cutscene = true
	else:
		in_cutscene = false
	pass		
	if Input.is_key_pressed(KEY_F2):
		current_cutscene = 0
		
func _on_InteractRay_SangCut():
	current_cutscene = 1
	print(current_cutscene)
