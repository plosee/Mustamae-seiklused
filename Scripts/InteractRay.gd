extends RayCast3D

var collider = null
signal kubikinteract
signal syringe
signal knife
signal kubikrefill

func _process(delta):
	$RichTextLabel.text = "."
	collider = get_collider()
	
	if collider != null:
		
		if collider.is_in_group("kubik1") || collider.is_in_group("syringe") || collider.is_in_group("knife"):
			$RichTextLabel.bbcode_text = "Interact [E]" #ui prompt
			
			if Input.is_action_just_pressed("interactE") && collider.is_in_group("kubik1"):
				kubikinteract.emit()
				if Global.KubikPickup == true:
						emit_signal("kubikrefill")
				else:
					Global.KubikPickup = true
				
			elif Input.is_action_just_pressed("interactE") && collider.is_in_group("syringe"):
				syringe.emit()
				Global.SyringePickup = true
				
			elif Input.is_action_just_pressed("interactE") && collider.is_in_group("knife"):
				knife.emit()
				Global.KnifePickup = true
