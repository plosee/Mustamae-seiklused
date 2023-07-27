extends Node

var KubikPickup : bool = false
var SyringePickup : bool = false
var KnifePickup : bool = false
var currentslot = 0

var SyringeEffect : bool = false

var KimuSmoke : bool = false
var KimuCapacity
var KimuPuffDemo = 1
var KimuPuffs

func _process(delta):
	KimuPuffs = clamp(KimuPuffDemo, 1, 600)
