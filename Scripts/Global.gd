extends Node
var randomvariabletest = 1
var in_cutscene = false
var current_cutscene = 0
func _ready():
	pass
	
func _process(delta):
	if current_cutscene > 0:
		in_cutscene = true
	else:
		in_cutscene = false
#	print(in_cutscene)
#	print(current_cutscene)
	print(randomvariabletest)

		
func _on_InteractRay_SangCut():
	current_cutscene = 1
	print(current_cutscene)
