extends Node

var KubikPickup = false
var SyringePickup = false
var KnifePickup = false
var currentslot = 0

var SyringeEffect = false
var KimuPuffs = 0

func _process(delta):
	clamp(KimuPuffs, 0, 100)
