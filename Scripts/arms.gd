extends Node3D

# kui midagi vajutatakse
func _unhandled_input(event):
	if event is InputEventKey:
		if event.keycode==49 || event.keycode==50 || event.keycode==51:
			$RootNode/vasak/AnimationPlayer.play("vasak-HandEquip")
			# equip animatsioon kui inv slotte vajutatakse
		if Global.currentslot == 1 && Global.KubikPickup == true:
			# kubik visible kui kubik inventorys
			$RootNode/vasak/kubikhand.visible = true
