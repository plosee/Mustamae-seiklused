extends RayCast

var time_in_seconds = 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal SangCut
signal KubikInteract

# Called when the node enters the scene tree for the first time.
func _ready():
	add_exception(owner)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(sangcunt)
	var collider = get_collider()
	
	#NPC INTERACTION
	$InteractPrompt.text = " "

	if collider != null:
		
		if  collider.is_in_group("NPC"):
			$InteractPrompt.text = "Vajuta [E]"
			
		if collider.is_in_group("NPC") and Input.is_action_just_pressed("interact"):
			emit_signal("SangCut")
			
		#kubik
		if collider.is_in_group("Kubik"):
			print("Kubik spotted")
			$InteractPrompt.text = "Vajuta [E]"

		if collider.is_in_group("Kubik") and Input.is_action_just_pressed("interact"):
			print("Kubik Pickup")
			#kubikinteract on queue_freemas said kubikut
			emit_signal("KubikInteract")
			$Achievemtn.text = "Korjasid UELS KUbiku"
			#timer
			yield(get_tree().create_timer(time_in_seconds), "timeout")
			$Achievemtn.text = " "
			

