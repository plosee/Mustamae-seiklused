extends Node3D


func _unhandled_input(event):
	if event is InputEventKey:
		
		if event.keycode==49 || event.keycode==50 || event.keycode==51:
			$RootNode/vasak/AnimationPlayer.play("parem|HandEquip")
		elif event.keycode==49 && Global.KubikPickup == true:
			$RootNode/vasak/kubik.visible = true
