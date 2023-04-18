extends Spatial

var wait_for_ready = 2
var time_in_seconds2 = 2
var time_in_seconds = 1

var sang_cutscene = 0
var cat_cutscene = 0

var t = 0.0


func _ready():
	#eyes reapplied incase it doesnt
	$Character/KinematicBody/Head/Camera.current = true
	
func _physics_process(delta):
#	print($kiisu.global_translation.y) #ignore, for kiisu pos debug if kiisu go retard
#	print($kiisu.global_translation.x)
	
	#diagbox animatsioonid
	if sang_cutscene == 0:
		$Character/KinematicBody/InteractRay.set_physics_process(true)
		if $Character/KinematicBody/InteractRay/Diabox.position.y < 1230:
			$Character/KinematicBody/InteractRay/Diabox.position.y += 8
			
			
	if sang_cutscene == 1:
		$Character/KinematicBody/InteractRay.set_physics_process(false)
		$Character/KinematicBody/InteractRay/InteractPrompt.text = " "
		if $Character/KinematicBody/InteractRay/Diabox.position.y > 940:
			$Character/KinematicBody/InteractRay/Diabox.position.y -= 8
	
	if cat_cutscene == 1:
#cut 1 ////////////////////////////////////////////////////////////////////////
		$KiisuCutscene/Camera.current = true 
		$Character/KinematicBody.global_translation = Vector3(1.8,0,0)
		$Character/KinematicBody/InteractRay.hide()
		$Character/KinematicBody.set_physics_process(false)
		$Character/KinematicBody.set_process_input(false)
		t = clamp(t, 0.0, 1.0)
		
		yield(get_tree().create_timer(time_in_seconds2), "timeout")
#cut 2 ////////////////////////////////////////////////////////////////////////
		$KiisuCutscene/Camera2.current = true 
		t += 0.002
		var munad = 1
		
		#ei tea kuidas lerp tootab niiet lets roll w it just works
		# sexual offender check
		#  kui offenses on olemas siis liiguta kassi
		while munad == 1:
			if get_node("kiisu") == null:
				break
			$kiisu.global_translation.y = lerp($kiisu.global_translation.y, 2, t)
			yield(get_tree().create_timer(time_in_seconds), "timeout")
			$kiisu.global_translation.y = 2 # it fixes pos
			break
		 # end check
#cut 3 ////////////////////////////////////////////////////////////////////////
		$KiisuCutscene/Camera3.current = true
		t = 0
		t += 0.1
		
		#be careful while loopidega, alati breaki need
		#if not broken fps go kaboosh and/or game crash
		while munad == 1:
			if get_node("kiisu") == null:
				break
			$kiisu.global_translation.x = lerp($kiisu.global_translation.x, 2, t)
			yield(get_tree().create_timer(time_in_seconds), "timeout")
			$kiisu.global_translation.x = 2
			break
		
		#give legs and eyes back
		$Character/KinematicBody/Head/Camera.current = true
		$Character/KinematicBody/InteractRay.show()
		$Character/KinematicBody.set_physics_process(true)
		$Character/KinematicBody.set_process_input(true)
		
		#viska kiisu shadow realmi// todo: add show kiisu from cockposition of char that is invisible at first
		$kiisu.hide()
		$kiisu/kas/CollisionShape.set_deferred("disabled", true)
		$kiisu/kas/Area/CollisionShape2.set_deferred("disabled", true)
		cat_cutscene = 0
#done ////////////////////////////////////////////////////////////////////////
		
func _input(event):
	if Input.is_action_just_pressed("secondary_interact"):
		
		#kui cutscene labi saab ss ta saab enda invaliidsusest yle
		sang_cutscene = 0
		$Character.show()
		$Character/KinematicBody.set_physics_process(true)
		$Character/KinematicBody.set_process_input(true)
		$Character/KinematicBody/Head/Camera.current = true
		
func _on_InteractRay_SangCut():
	
	#char hakkab sangcuti parast invaliidiks ja kummituseks
	$Sang/SangArea/SangCam.current = true
	$Character.hide()
	$Character/KinematicBody.set_physics_process(false)
	$Character/KinematicBody.set_process_input(false)
	sang_cutscene = 1
	
func _on_InteractRay_CatScene():
	 cat_cutscene = 1
