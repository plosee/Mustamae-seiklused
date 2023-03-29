extends Spatial


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
		
