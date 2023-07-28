extends Node3D

signal kimu
signal kimusmoke
signal syringe
signal stab

func _process(delta):
	# Kui kubik/item on olemas, naita kasi
	if Global.currentslot == 1 && Global.KubikPickup == true:
		$CharacterBody3D/Head/hands/equphand.visible = true
	else:
		$CharacterBody3D/Head/hands/vasak/kubik.visible = false
	
	# Kimu kood
	if Global.KimuSmoke == false:
		$CharacterBody3D/Head/GPUParticles3D.emitting = false
		
	if Global.currentslot == 1 && Global.KubikPickup == true && Input.is_action_pressed('interactM1'):
		kimu.emit()
		Global.KimuSmoke = false
		
	if Global.KimuPuffs > 1 && Global.KubikPickup == true && Input.is_action_just_released("interactM1"):
		Global.KimuSmoke = true
		$CharacterBody3D/Head/GPUParticles3D.emitting = true
		
	# Syringe kood
	if Global.currentslot == 3 && Global.SyringePickup == true && Input.is_action_just_pressed('interactM1'):
		Global.SyringeEffect = true
		await get_tree().create_timer(5).timeout
		Global.SyringeEffect = false 
		
	# Nuga kood
	if Global.currentslot == 2 && Global.KnifePickup == true && Input.is_action_just_pressed('interactM1'):
		stab.emit()
