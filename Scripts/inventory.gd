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
			$inv1.color = selected
			$inv2.color = unselected
			$inv3.color = unselected
		elif event.keycode==50:
			$inv2.color = selected
			$inv1.color = unselected
			$inv3.color = unselected
		elif event.keycode==51:
			$inv3.color = selected
			$inv1.color = unselected
			$inv2.color = unselected
	else:
		pass
