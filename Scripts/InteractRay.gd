extends RayCast3D

var collider = null
signal kubikinteract
signal syringe
signal knife

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RichTextLabel.text = "."
	collider = get_collider()
	
	if collider != null:
		
		if collider.is_in_group("kubik1") || collider.is_in_group("syringe") || collider.is_in_group("knife"):
			$RichTextLabel.bbcode_text = "Interact [E]" #ui prompt
			
			if Input.is_action_just_pressed("interactE") && collider.is_in_group("kubik1"):
				kubikinteract.emit()
				
			elif Input.is_action_just_pressed("interactE") && collider.is_in_group("syringe"):
				syringe.emit()
				
			elif Input.is_action_just_pressed("interactE") && collider.is_in_group("knife"):
				knife.emit()
