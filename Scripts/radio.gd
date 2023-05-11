extends KinematicBody
var playing = false
func _ready():
	pass # Replace with function body.


func _on_InteractRay_radio():
	playing = !playing
	$AudioStreamPlayer3D.playing = playing
