extends Node3D

# kui midagi vajutatakse
func _ready():
	$RootNode/vasak/AnimationPlayer.play("vasak-Idle")

func _unhandled_input(event):
	if event is InputEventKey:
		if event.keycode==49 || event.keycode==50 || event.keycode==51:
			$RootNode/vasak/AnimationPlayer.play("vasak-HandEquip")
			# equip animatsioon kui inv slotte vajutatakse
			
		elif event.keycode==32:
			$RootNode/vasak/AnimationPlayer.play("vasak-HandDequip")
			# stowing animation kui 'spacebar' vajutatakse
			
		if Global.currentslot == 1 && Global.KubikPickup == true:
			# kubik visible kui kubik inventorys ja kubiku slot
			$RootNode/vasak/kubikhand.visible = true
			
		else:
			$RootNode/vasak/kubikhand.visible = false
