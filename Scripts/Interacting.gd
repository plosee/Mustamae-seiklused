extends Node3D

signal kimu
signal kimusmoke
signal syringe
signal stab

func _process(delta):
	# Kui kubik/item on olemas, naita kasi
#	if Global.currentslot == 1 && Global.KubikPickup == true:
#		$CharacterBody3D/Head/hands/equphand.visible = true
#	else:
#		$CharacterBody3D/Head/hands/vasak/kubik.visible = false
	
	# Kimu kood
	if Global.KimuSmoke == false:
		# lopeta kimu particle
		$CharacterBody3D/Head/GPUParticles3D.emitting = false
		
	if Global.currentslot == 1 && Global.KubikPickup == true && Input.is_action_just_pressed('interactM1'):
		# mangi puff animatsiooni kui m1 vajutatakse
		$CharacterBody3D/Head/arms/RootNode/vasak/AnimationPlayer.play("vasak-Puff")
		
	if Global.currentslot == 1 && Global.KubikPickup == true && Input.is_action_pressed('interactM1'):
		# lopeta puffimine kui samal ajal kimub
		# kimu signal addib kui kaua puffida saab // hard limit
		kimu.emit()
		Global.KimuSmoke = false

	if Global.KimuPuffs > 1 && Global.KubikPickup == true && Input.is_action_just_released("interactM1"):
		Global.KimuSmoke = true
		$CharacterBody3D/Head/GPUParticles3D.emitting = true
		$CharacterBody3D/Head/arms/RootNode/vasak/AnimationPlayer.play("vasak-PuffStop")
		# naita particle kuna hingab valja
		
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
