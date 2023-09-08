extends Node

# Is 'x' item picked up from the ground
var KubikPickup : bool = false
var SyringePickup : bool = false
var KnifePickup : bool = false
var ViinPickup : int = 0

# Current inventory slot equipped
var currentslot = 0

# Syringeeffect on naha character koodis, kas player on endale aidsi saanud
var SyringeEffect : bool = false

# Kimusmoke on et naha, kas player higab valja. todo: rework
var KimuSmoke : bool = false
# kimu capacity on lis palju vedla veel on
var KimuCapacity : float = 5.0
# KimupuffDemo on tehtud selleks, et seda saaks clampida (min max value)
var KimuPuffs = 1

var health : float = 100
var enemy_health : float = 100
var in_main : bool = true

func _process(delta):
	
	if get_tree().get_current_scene().name == "Main":
		in_main = true
	else:
		in_main = false

