extends Node3D

signal kimu
signal syringe
signal stab

func _process(delta):
	if Input.is_action_just_pressed("inv1") && Global.KubikPickup == true && Input.is_action_just_pressed('interactM1'):
		kimu.emit()
	if Input.is_action_just_pressed("inv1") && Global.SyringePickup == true && Input.is_action_just_pressed('interactM1'):
		syringe.emit()
	if Input.is_action_just_pressed("inv1") && Global.KnifePickup == true && Input.is_action_just_pressed('interactM1'):
		stab.emit()
