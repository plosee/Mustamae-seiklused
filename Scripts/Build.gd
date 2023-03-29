extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Global.current_cutscene > 0:
		$Global.in_cutscene == true
	else:
		$Global.in_cutscene == false
	if $Global.current_cutscene == 1:
		$Sang/SangArea/SangCam.current = true
		if $Character/KinematicBody/InteractRay/Diabox.position.y > 940:
			$Character/KinematicBody/InteractRay/Diabox.position.y -= 8
	print($Character/KinematicBody/InteractRay/Diabox.position.y)
		
