extends Control

var selected = Color(1, 1, 1)
var unselected = Color(1, 1, 1, 0.25)

func _ready():
	$inv1.color = unselected
	$inv2.color = unselected
	$inv3.color = unselected

func _unhandled_input(event):
	if event is InputEventKey:
		if event.keycode==49:
			if Global.KubikPickup:
				$inv1/kubik.show()
			$inv1.color = selected
			$inv2.color = unselected
			$inv3.color = unselected
		elif event.keycode==50:
			if Global.KnifePickup:
				$inv2/nuga.show()
			$inv2.color = selected
			$inv1.color = unselected
			$inv3.color = unselected
		elif event.keycode==51:
			if Global.SyringePickup:
				$inv3/syringe.show()
			$inv3.color = selected
			$inv1.color = unselected
			$inv2.color = unselected
	else:
		pass


func _on_interact_ray_kubikinteract():
	$inv1/kubik.visible = true
	
func _on_interact_ray_knife():
	$inv2/nuga.visible = true
	
func _on_interact_ray_syringe():
	$inv3/syringe.visible = true


