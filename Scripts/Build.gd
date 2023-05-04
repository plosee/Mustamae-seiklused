extends Spatial

var wait_for_ready = 2
var time_in_seconds2 = 2
var time_in_seconds = 1

var sang_cutscene = 0
var cat_cutscene = 0

var catcut2 = false
var catcut3 = false

var t = 0.0

func _ready():
	#eyes reapplied incase it doesnt DO IT ITSELF
	$Character/KinematicBody/Head/Camera.current = true
	$particle_cache.emitting = true
	
func _physics_process(delta):
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
		if Input.is_action_just_pressed("mouseinteract"):
			$Character/KinematicBody/InteractRay/Diabox/RichTextLabel.text = "Kui sa tahad minu eest palvetada siis mine maja taha, annan sulle paar kommi kui lahed ka"
			
	#cat cutscene lerp for animation
	if cat_cutscene == 1:
		if catcut2 == true and is_instance_valid(get_node("/root/Spatial/kiisu")) == true:
			t += 0.002
			$kiisu.global_translation.y = lerp($kiisu.global_translation.y, 2, t)
			
		if catcut3 == true and is_instance_valid(get_node("/root/Spatial/kiisu")) == true:
			t = 0
			t += 0.1
			$kiisu.global_translation.x = lerp($kiisu.global_translation.x, 2, t)

func _input(event):
	if Input.is_action_just_pressed("secondary_interact"):
		#kui cutscene katkestatakse saab ss ta saab enda invaliidsusest yle
		sang_cutscene = 0
		if cat_cutscene == 0:
			$Character.show()
			$Character/KinematicBody.set_physics_process(true)
			$Character/KinematicBody.set_process_input(true)
			$Character/KinematicBody/Head/Camera.current = true
		
func _on_InteractRay_SangCut():
	#char hakkab sangcuti parast invaliidiks ja kummituseks
	$Character/KinematicBody/InteractRay/Diabox/RichTextLabel.text = "this is sample text you should ingnornetne this and listen to the teachings of our lord and savour sang sangman"
	$Sang/SangArea/SangCam.current = true
	$Character.hide()
	$Character/KinematicBody.set_physics_process(false)
	$Character/KinematicBody.set_process_input(false)
	sang_cutscene = 1
	
func _on_InteractRay_CatScene():
	cat_cutscene = 1
	if cat_cutscene == 1:
#cut 1 ////////////////////////////////////////////////////////////////////////
		print("cut1")
		
		$KiisuCutscene/Camera.current = true 									#cutscene cam 1
		$Character/KinematicBody.global_translation = Vector3(1.8,0,0)			#character TP
		$Character/KinematicBody/InteractRay.collision_mask = 1		#interact prompt disabled
		$Character/KinematicBody/InteractRay/InteractPrompt.text = " "
		$Character/KinematicBody.set_physics_process(false)						#character movement disable
		$Character/KinematicBody.set_process_input(false)
		
		t = clamp(t, 0.0, 1.0)													#lerp t value clamp
		yield(get_tree().create_timer(time_in_seconds2), "timeout")				#sleep for 2 sec
#cut 2 ////////////////////////////////////////////////////////////////////////
		catcut2 = true															#enable lerp for cut 2
		print("cut2")
		$KiisuCutscene/Camera2.current = true 									#cut 2 camera
		yield(get_tree().create_timer(time_in_seconds), "timeout")				#sleep for 1 sec
		$kiisu.global_translation.y = 2 										#tp kiisu y axis to 2 for good measure
		catcut2 = false															#disable lerp for cut 2
#cut 3 ////////////////////////////////////////////////////////////////////////	
		catcut3 = true															#enable lerp for cut 3
		print("cut3")
		$KiisuCutscene/Camera3.current = true									#cut 3 camera
		yield(get_tree().create_timer(time_in_seconds2), "timeout")				#sleep for 2 sec
		$kiisu.global_translation.x = 2											#tp kiisu x axis to 2 for good measure
		catcut3 = false															#disable lerp for cut 3
#finish ///////////////////////////////////////////////////////////////////////
		$Character/KinematicBody/Head/Camera.current = true						#enable char cam
		$Character/KinematicBody.set_physics_process(true)						#enable character movement
		$Character/KinematicBody.set_process_input(true)
		$Character/KinematicBody/dickcat.show()									#show cock
		$kiisu.queue_free()														#delete kiisu node for memory
		cat_cutscene = 0														#disable cat cutscene finally
		$Character/KinematicBody/InteractRay/Achievemtn.text = "obTained C A T C O C K (patent pending)"
		$Character/KinematicBody/InteractRay.collision_mask = 8
		yield(get_tree().create_timer(5), "timeout")							#interact prompt enable
		$Character/KinematicBody/InteractRay/Achievemtn.text = ""

