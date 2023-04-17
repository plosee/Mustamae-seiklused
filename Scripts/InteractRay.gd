extends RayCast

var time_in_seconds = 5 #timer

signal SangCut
signal KubikInteract

func _ready():
	add_exception(owner)
	
func _physics_process(delta):
	
	if Input.is_action_just_pressed("interactt"):
		print("interacted")
	var collider = get_collider()
	$InteractPrompt.text = " "
	#NPC INTERACTION
	
	if collider != null:
		
		if  collider.is_in_group("NPC"):
			$InteractPrompt.text = "Vajuta [E]"
			
		if collider.is_in_group("NPC") and Input.is_action_just_pressed("interactt"):
			emit_signal("SangCut")
			
			
		#kubik
		
		if collider.is_in_group("Kubik"):
			print("Kubik spotted")
			$InteractPrompt.text = "Vajuta [E]"

		if collider.is_in_group("Kubik") and Input.is_action_just_pressed("interactt"):
			print("Kubik Pickup")
			#kubikinteract on queue_freemas said kubikut
			emit_signal("KubikInteract")
			$Achievemtn.text = "Korjasid UELS KUbiku"
			#timer
			yield(get_tree().create_timer(time_in_seconds), "timeout")
			$Achievemtn.text = " "
