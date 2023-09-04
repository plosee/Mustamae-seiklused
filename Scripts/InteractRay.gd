extends RayCast3D

var collider = null

signal kubikinteract
signal kubikinteract2
signal syringe
signal knife
signal kubikrefill
signal NPC
signal Viin

func _process(delta):
	collider = get_collider()
	
	if collider != null:
		
		if collider.is_in_group("kubik1") || collider.is_in_group("kubik2") || collider.is_in_group("syringe") || collider.is_in_group("knife") || collider.is_in_group("NPC") || collider.is_in_group("Viin"):
			$crosshair.text ="[center]Interact[e][/center]" #ui prompt
			
			# kubiku pickup kood, barebones refill mechanic
			if Input.is_action_just_pressed("interactE") && collider.is_in_group("kubik1") || Input.is_action_just_pressed("interactE") && collider.is_in_group("kubik2"):
				if Global.KubikPickup == true:
					$Itempickup.text = "[center]Kubik refill!!11!1[/center]"
				else:
					$Itempickup.text = "[center]Picked up Kubik[/center]"
					
				if collider.is_in_group("kubik1"):
					kubikinteract.emit()
				else:
					kubikinteract2.emit()
					
				Global.KubikPickup = true
				Global.KimuCapacity = 100.0
				if $Itempickup.text != "":
					await get_tree().create_timer(3).timeout
					$Itempickup.text = ""
				
			# syringe pickup
			elif Input.is_action_just_pressed("interactE") && collider.is_in_group("syringe"):
				syringe.emit()
				Global.SyringePickup = true
				$Itempickup.text = "[center]Picked up Syringe[/center]"
				if $Itempickup.text != "":
					await get_tree().create_timer(3).timeout
					$Itempickup.text = ""
			# nuga pickup
			elif Input.is_action_just_pressed("interactE") && collider.is_in_group("knife"):
				knife.emit()
				Global.KnifePickup = true
				$Itempickup.text = "[center]Picked up Knife[/center]"
				if $Itempickup.text != "":
					await get_tree().create_timer(3).timeout
					$Itempickup.text = ""
			# viin pickup
			elif Input.is_action_just_pressed("interactE") && collider.is_in_group("Viin"):
				Viin.emit()
				Global.ViinPickup = 1
				$Itempickup.text = "[center]Picked up Vodka[/center]"
				if $Itempickup.text != "":
					await get_tree().create_timer(3).timeout
					$Itempickup.text = ""
			# NPC interaction
			elif Input.is_action_just_pressed("interactE") && collider.is_in_group("NPC"):
				NPC.emit()
				# using the dialogue addon to get textbox n shit
				DialogueManager.show_example_dialogue_balloon(load("res://Misc/Dialouges/JakePaulDebug.dialogue"), "start")

				
	else:
		$crosshair.text = "[center]·[/center]"
		
