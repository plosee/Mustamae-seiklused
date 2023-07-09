extends RayCast

var time_in_seconds = 5 #timer
var collider = null

signal CatScene
signal SangCut

signal KubikInteract
signal Kubik2Interact
signal KubikRefill
signal radio
signal KnifeInteract

signal SyringeInteract
signal Syringe2Interact

signal hurtdummy
signal hurtvanamees

var kubikinventory = false


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
		#object layer = 4, interactray mask = 4 //
		
		#Kui interact siiani ei toota, siis tee kindlaks et sa panid grupi AREA mitte SPATIALNODEi peale, ara ole tard nagu mina //
		#you would think if you group a parent node then it's children will get grouped the same, but ig mixed aint whites nor blacks ~p
		if collider.is_in_group("NPC") || collider.is_in_group("Kubik") || collider.is_in_group("knife") || collider.is_in_group("Kass") || collider.is_in_group("Syringe") || collider.is_in_group("Kubik2") || collider.is_in_group("Syringe2")|| collider.is_in_group("radio"):
			$InteractPrompt.text = "Vajuta [E]"
			
		elif collider.is_in_group("Vanamees") || collider.is_in_group("Dummy"):
			$InteractPrompt.text = "X"
			
		if collider.is_in_group("NPC") and Input.is_action_just_pressed("interact"):
			emit_signal("SangCut")
			
		elif collider.is_in_group("Kass") and Input.is_action_just_pressed("interact"):
			emit_signal("CatScene")
		if collider.is_in_group("radio") and Input.is_action_just_pressed("interact"):
			emit_signal("radio")
			
		if collider.is_in_group("Kubik2") and Input.is_action_just_pressed("interact") and kubikinventory == true or collider.is_in_group("Kubik") and Input.is_action_just_pressed("interact") and kubikinventory == true:
			emit_signal("KubikRefill")
			emit_signal("KubikInteract")
			emit_signal("Kubik2Interact")
			
			$Achievemtn.text = "Kubik refill"
			yield(get_tree().create_timer(2), "timeout")
			$Achievemtn.text = " "
			
		elif collider.is_in_group("Kubik") and Input.is_action_just_pressed("interact"):
			emit_signal("KubikInteract")
			
			$Achievemtn.text = "Korjasid ules kubiku"
			yield(get_tree().create_timer(2), "timeout")
			$Achievemtn.text = " "
			kubikinventory = true
			
		elif collider.is_in_group("Kubik2") and Input.is_action_just_pressed("interact"):
			#kubikinteract on queue_freemas said kubikut
			emit_signal("Kubik2Interact")
			
			$Achievemtn.text = "Korjasid ules kubiku"
			yield(get_tree().create_timer(2), "timeout")
			$Achievemtn.text = " "
			kubikinventory = true
		
		elif collider.is_in_group("knife") and Input.is_action_just_pressed("interact"):
			emit_signal("KnifeInteract")
			
			$Achievemtn.text = "Korjasid ules noa"
			yield(get_tree().create_timer(2), "timeout")
			$Achievemtn.text = " "
			
		elif collider.is_in_group("Syringe") and Input.is_action_just_pressed("interact"):
			emit_signal("SyringeInteract")
			$Achievemtn.text = "Korjasid ules mingi suvalise sustla maast"
			yield(get_tree().create_timer(2), "timeout")
			$Achievemtn.text = "See on vist juba kasutatud"
			yield(get_tree().create_timer(0.75), "timeout")
			$Achievemtn.text = " "
		
		elif collider.is_in_group("Syringe2") and Input.is_action_just_pressed("interact"):
			emit_signal("Syringe2Interact")
			

func _on_KinematicBody_stab():
	if collider != null:
		if collider.is_in_group("Vanamees"):
			emit_signal("hurtvanamees")
			
		elif collider.is_in_group("Dummy"):
			emit_signal("hurtdummy")
