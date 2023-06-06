extends Node3D

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
	$Character/CharacterBody3D/Head/Camera3D.current = true
	$particle_cache.emitting = true

	
func _physics_process(delta):
	#diagbox animatsioonid
	if Global.showfps:
		$CanvasLayer/FPS.text = "FPS:" + str(Engine.get_frames_per_second())
		$CanvasLayer/FPS.visible = true
	else:
		$CanvasLayer/FPS.visible = false
	if sang_cutscene == 0:
		$Character/CharacterBody3D/InteractRay.set_physics_process(true)
		if $Character/CharacterBody3D/InteractRay/Diabox.position.y < 1230:
			$Character/CharacterBody3D/InteractRay/Diabox.position.y += 8
			
	if sang_cutscene == 1:
		$Character/CharacterBody3D/InteractRay.set_physics_process(false)
		$Character/CharacterBody3D/InteractRay/InteractPrompt.text = " "
		if $Character/CharacterBody3D/InteractRay/Diabox.position.y > 940:
			$Character/CharacterBody3D/InteractRay/Diabox.position.y -= 8
		if Input.is_action_just_pressed("mouseinteract"):
			$Character/CharacterBody3D/InteractRay/Diabox/RichTextLabel.text = "Kui sa tahad minu eest palvetada siis mine Aadressile Sääse 1, annan sulle paar kommi kui lahed ka"
			
	#cat cutscene lerp for animation
	if cat_cutscene == 1:
		if catcut2 == true and is_instance_valid(get_node("/root/Node3D/kiisu")) == true:
			t += 0.002
			$kiisu.global_position.y = lerp($kiisu.global_position.y, 2, t)
			
		if catcut3 == true and is_instance_valid(get_node("/root/Node3D/kiisu")) == true:
			t = 0
			t += 0.1
			$kiisu.global_position.x = lerp($kiisu.global_position.x, 2, t)

func _input(event):
	if Input.is_action_just_pressed("secondary_interact"):
		#kui cutscene katkestatakse saab ss ta saab enda invaliidsusest yle
		sang_cutscene = 0
		if cat_cutscene == 0:
			$Character.show()
			$Character/CharacterBody3D.set_physics_process(true)
			$Character/CharacterBody3D.set_process_input(true)
			$Character/CharacterBody3D/Head/Camera3D.current = true
		
func _on_InteractRay_SangCut():
	#char hakkab sangcuti parast invaliidiks ja kummituseks
	$Character/CharacterBody3D/InteractRay/Diabox/RichTextLabel.text = "this is sample text you should ingnornetne this and listen to the teachings of our lord and savour sang sangman"
	$Sang/SangArea/SangCam.current = true
	$Character.hide()
	$Character/CharacterBody3D.set_physics_process(false)
	$Character/CharacterBody3D.set_process_input(false)
	sang_cutscene = 1
	
func _on_InteractRay_CatScene():
	cat_cutscene = 1
	if cat_cutscene == 1:
#cut 1 ////////////////////////////////////////////////////////////////////////
		print("cut1")
		
		$KiisuCutscene/Camera3D.current = true 									#cutscene cam 1
		$Character/CharacterBody3D.global_position = Vector3(1.8,0,0)			#character TP
		$Character/CharacterBody3D/InteractRay.collision_mask = 1		#interact prompt disabled
		$Character/CharacterBody3D/InteractRay/InteractPrompt.text = " "
		$Character/CharacterBody3D.set_physics_process(false)						#character movement disable
		$Character/CharacterBody3D.set_process_input(false)
		
		t = clamp(t, 0.0, 1.0)													#lerp t value clamp
		await get_tree().create_timer(time_in_seconds2).timeout				#sleep for 2 sec
#cut 2 ////////////////////////////////////////////////////////////////////////
		catcut2 = true															#enable lerp for cut 2
		print("cut2")
		$KiisuCutscene/Camera2.current = true 									#cut 2 camera
		await get_tree().create_timer(time_in_seconds).timeout				#sleep for 1 sec
		$kiisu.global_position.y = 2 										#tp kiisu y axis to 2 for good measure
		catcut2 = false															#disable lerp for cut 2
#cut 3 ////////////////////////////////////////////////////////////////////////	
		catcut3 = true															#enable lerp for cut 3
		print("cut3")
		$KiisuCutscene/Camera3.current = true									#cut 3 camera
		await get_tree().create_timer(time_in_seconds2).timeout				#sleep for 2 sec
		$kiisu.global_position.x = 2											#tp kiisu x axis to 2 for good measure
		catcut3 = false															#disable lerp for cut 3
#finish ///////////////////////////////////////////////////////////////////////
		$Character/CharacterBody3D/Head/Camera3D.current = true						#enable char cam
		$Character/CharacterBody3D.set_physics_process(true)						#enable character movement
		$Character/CharacterBody3D.set_process_input(true)
		$Character/CharacterBody3D/dickcat.show()									#show cock
		$kiisu.queue_free()														#delete kiisu node for memory
		cat_cutscene = 0														#disable cat cutscene finally
		$Character/CharacterBody3D/InteractRay/Achievemtn.text = "obTained C A T C O C K (patent pending)"
		$Character/CharacterBody3D/InteractRay.collision_mask = 8
		await get_tree().create_timer(5).timeout							#interact prompt enable
		$Character/CharacterBody3D/InteractRay/Achievemtn.text = ""

