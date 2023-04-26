extends RayCast

var time_in_seconds = 5 #timer

signal SangCut
signal KubikInteract
signal CatScene
signal KnifeInteract

func _ready():
	add_exception(owner)
	
func _physics_process(delta):
	
#	if Input.is_action_just_pressed("interact"):
#		print("interacted")
	var collider = get_collider()
	
	#NPC INTERACTION
	
	if collider != null:
		
		#Kui teed uue interactable objecti lisa siia if statementi, saveb ruumi. ~ A-1		
		#Iga kord kui uue inter_objecti lisad siis tee kindlaks, et selle 'Area' nodei collision layer on 4 peal //
		#Kui kustutad objekti siis pane selle signal emit if statementi, et see teeks kindlaks, et node eksisteerib //
		
		#Layer annab Maskile infot ning vastupidi, aga layer ei saa layerile infot anda //
		#aka kui object layer on 2 ja interactray mask on 2, siis sa saad interactida sellega //
		#interactrayle saab ainult maski lisada, niiet jata see meelde //
		
		#rn Ground Mask = 1, kinematicbody layer = 1 //
		#object layer = 4, interactray mask = 4 ~ p
		
		if  collider.is_in_group("NPC") || collider.is_in_group("Kubik") || collider.is_in_group("Knife") || collider.is_in_group("Kass"):
			$InteractPrompt.text = "Vajuta [E]"

		if collider.is_in_group("NPC") and Input.is_action_just_pressed("interact"):
			emit_signal("SangCut")
			
		if collider.is_in_group("Kass") and Input.is_action_just_pressed("interact"):
			emit_signal("CatScene")
			
		if is_instance_valid(get_node("/root/Spatial/kubik")) == true and collider.is_in_group("Kubik") and Input.is_action_just_pressed("interact"):
			print("Kubik Pickup")
			#kubikinteract on queue_freemas said kubikut
			emit_signal("KubikInteract")
			
			$Achievemtn.text = "Korjasid ules kubiku"
			yield(get_tree().create_timer(time_in_seconds), "timeout")
			$Achievemtn.text = " "
			
		if is_instance_valid(get_node("/root/Spatial/kubik")) == true and collider.is_in_group("Knife") and Input.is_action_just_pressed("interact"):
			emit_signal("KnifeInteract")
			
			$Achievemtn.text = "Korjasid ules noa"
			yield(get_tree().create_timer(time_in_seconds), "timeout")
			$Achievemtn.text = " "
			
	else:
		$InteractPrompt.text = "·"
