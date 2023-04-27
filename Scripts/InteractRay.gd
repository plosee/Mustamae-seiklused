extends RayCast

var time_in_seconds = 5 #timer
var collider = null

signal CatScene
signal SangCut

signal KubikInteract
signal KnifeInteract

signal hurtdummy
signal hurtvanamees


func _ready():
	add_exception(owner)
	
func _physics_process(delta):
	
#	if Input.is_action_just_pressed("interact"):
#		print("interacted")
	collider = get_collider()
	
	$InteractPrompt.text = "·"
	#NPC INTERACTION
	
	
	if collider != null:
		#Kui teed uue interactable objecti lisa siia if statementi, saveb ruumi. ~ A-1
		
		#Iga kord kui uue inter_objecti lisad siis tee kindlaks, et selle 'Area' nodei collision layer on 4 peal //
		#Kui kustutad objekti siis pane selle signal emit if statementi, et see teeks kindlaks, et node eksisteerib //
		#ja kindlasti pane see 'elif' statementi, muidu mang crashib proovides molemat checkida //
		
		#Layer annab Maskile infot ning vastupidi, aga layer ei saa layerile infot anda //
		#aka kui object layer on 2 ja interactray mask on 2, siis sa saad interactida sellega //
		#interactrayle saab ainult maski lisada, niiet jata see meelde //
		
		#rn Ground Mask = 1, kinematicbody layer = 1 //
		#object layer = 4, interactray mask = 4 ~ p
		
		if collider.is_in_group("NPC") || collider.is_in_group("Kubik") || collider.is_in_group("knife") || collider.is_in_group("Kass"):
			$InteractPrompt.text = "Vajuta [E]"
			
		elif collider.is_in_group("Vanamees") || collider.is_in_group("Dummy"):
			$InteractPrompt.text = "X"
			
		if collider.is_in_group("NPC") and Input.is_action_just_pressed("interact"):
			emit_signal("SangCut")
			
		elif collider.is_in_group("Kass") and Input.is_action_just_pressed("interact"):
			emit_signal("CatScene")
			
		if is_instance_valid(get_node("/root/Spatial/kubik")) == true and collider.is_in_group("Kubik") and Input.is_action_just_pressed("interact"):
			#kubikinteract on queue_freemas said kubikut
			emit_signal("KubikInteract")
			
			$Achievemtn.text = "Korjasid ules kubiku"
			yield(get_tree().create_timer(time_in_seconds), "timeout")
			$Achievemtn.text = " "
			
		elif is_instance_valid(get_node("/root/Spatial/knife")) == true and collider.is_in_group("knife") and Input.is_action_just_pressed("interact"):
			emit_signal("KnifeInteract")
			
			$Achievemtn.text = "Korjasid ules noa"
			yield(get_tree().create_timer(time_in_seconds), "timeout")
			$Achievemtn.text = " "


func _on_KinematicBody_stab():
	if collider != null:
		if collider.is_in_group("Vanamees"):
			emit_signal("hurtvanamees")
			
		elif collider.is_in_group("Dummy"):
			emit_signal("hurtdummy")
