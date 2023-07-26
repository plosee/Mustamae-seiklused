extends Node3D

signal kimu
signal syringe
signal stab

func _process(delta):
	if Global.currentslot == 1 && Global.KubikPickup == true && Input.is_action_just_pressed('interactM1'):
		kimu.emit()
		print("ma kimun")
		#i have no fucking idea how to make this shit work correctly
		#i have no fucking clue how we did this last time
		#i have no fucking thought how to make this var increase gradually
		
		#haiku time
		
		#help me jesus christ
		#i cant make this code work, fuck.
		#god has left me
		# ~P
		
	if Global.currentslot == 3 && Global.SyringePickup == true && Input.is_action_just_pressed('interactM1'):
		Global.SyringeEffect = true
		await get_tree().create_timer(5).timeout
		Global.SyringeEffect = false 
		
	if Global.currentslot == 2 && Global.KnifePickup == true && Input.is_action_just_pressed('interactM1'):
		stab.emit()
