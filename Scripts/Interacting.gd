extends Node3D

signal kimu
signal kimusmoke
signal syringe
signal stab

func _process(delta):
	# Kimu kood
	if Global.KimuSmoke == false:
		# lopeta kimu particle
		$CharacterBody3D/Head/KimuParticles.emitting = false
		
	if Global.currentslot == 1 && Global.KubikPickup == true && Input.is_action_just_pressed('interactM1') && Global.KimuPuffs < 500: # animation 1
		# mangi puff animatsiooni kui m1 vajutatakse
		$CharacterBody3D/Head/arms/RootNode/vasak/AnimationPlayer.play("vasak-Puff")
		
	if Global.currentslot == 1 && Global.KubikPickup == true && Input.is_action_pressed('interactM1') && Global.KimuPuffs < 500: # animation 2
		# lopeta puffimine kui samal ajal kimub
		# kimu signal addib kui kaua puffida saab/kui kaua particled valja tulevad
		kimu.emit()
		Global.KimuSmoke = false

	if $CharacterBody3D/Head/KimuParticles.emitting:
		if Global.health < 101:
			$CharacterBody3D/Head/arms/RootNode/inventory.health += 0.1
		
	if Global.KimuPuffs > 1 && Global.KubikPickup == true && Input.is_action_just_released("interactM1") || Global.KimuCapacity <= 1.0 || Global.KimuPuffs == 500: # animation 3
		Global.KimuSmoke = true
		$CharacterBody3D/Head/KimuParticles.emitting = true
		$CharacterBody3D/Head/arms/RootNode/vasak/AnimationPlayer.play("vasak-PuffStop")
		await get_tree().create_timer(1).timeout
		
		# naita particle kuna hingab valja
		if Global.KimuCapacity <= 1.0:
			$CharacterBody3D/Head/arms/RootNode/vasak/kubikhand.visible = false
			$CharacterBody3D/Head/arms/RootNode/vasak/AnimationPlayer.play("vasak-HandDequip")
			await get_tree().create_timer(1).timeout
			$CharacterBody3D/Head/arms/RootNode/vasak/AnimationPlayer.play("vasak-Idle")
			Global.currentslot = 0
			Global.KimuCapacity = 100.0
			Global.KubikPickup = false
		
	# Syringe kood
	if Global.currentslot == 3 && Global.SyringePickup == true && Input.is_action_just_pressed('interactM1'):
		# Speed boost 5 sekundit
		Global.SyringeEffect = true
		await get_tree().create_timer(5).timeout
		Global.SyringeEffect = false 
		
	# Nuga kood
	if Global.currentslot == 2 && Global.KnifePickup == true && Input.is_action_just_pressed('interactM1'):
		stab.emit()


func _on_animation_player_animation_finished(anim_name):
	# puffidle animatsioon kui esimene anim saab labi
	if anim_name == "vasak-Puff":
		$CharacterBody3D/Head/arms/RootNode/vasak/AnimationPlayer.play("vasak-PuffIdle")
