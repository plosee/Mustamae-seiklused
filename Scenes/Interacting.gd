extends Node3D

signal kimu
signal kimusmoke
signal syringe
signal stab

func _process(delta):
	if Global.currentslot == 1 && Global.KubikPickup == true && Input.is_action_pressed('interactM1'):
		kimu.emit()
		Global.KimuSmoke = false
	if Global.currentslot == 1 && Global.KubikPickup == true && Input.is_action_just_released("interactM1"):
		Global.KimuSmoke = true
			
	if Global.currentslot == 3 && Global.SyringePickup == true && Input.is_action_just_pressed('interactM1'):
		Global.SyringeEffect = true
		await get_tree().create_timer(5).timeout
		Global.SyringeEffect = false 
		
	if Global.currentslot == 2 && Global.KnifePickup == true && Input.is_action_just_pressed('interactM1'):
		stab.emit()
