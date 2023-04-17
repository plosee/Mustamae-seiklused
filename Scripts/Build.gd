extends Spatial

var current_cutscene = 0

#camera for safetty
func _ready():
	$Character/KinematicBody/Head/Camera.current = true

func _physics_process(delta):
	#daigbox anim
	if current_cutscene == 0:
		$Character/KinematicBody/InteractRay.set_physics_process(true)
		if $Character/KinematicBody/InteractRay/Diabox.position.y < 1230:
			$Character/KinematicBody/InteractRay/Diabox.position.y += 8
			
			#daigbox anim
	if current_cutscene == 1:
		$Character/KinematicBody/InteractRay.set_physics_process(false)
		$Character/KinematicBody/InteractRay/InteractPrompt.text = " "
		if $Character/KinematicBody/InteractRay/Diabox.position.y > 940:
			$Character/KinematicBody/InteractRay/Diabox.position.y -= 8
		
		
		#kui cutscene labi saab ss ta saab enda invaliidsusest yle
func _input(event):
	if Input.is_action_just_pressed("secondary_interact"):
		current_cutscene = 0
		$Character.show()
		$Character/KinematicBody.set_physics_process(true)
		$Character/KinematicBody.set_process_input(true)
		$Character/KinematicBody/Head/Camera.current = true
		
		#sangcut, hakkab invaliidiks ja nahtamatuks
func _on_InteractRay_SangCut():
	$Sang/SangArea/SangCam.current = true
	$Character.hide()
	$Character/KinematicBody.set_physics_process(false)
	$Character/KinematicBody.set_process_input(false)
	current_cutscene = 1
