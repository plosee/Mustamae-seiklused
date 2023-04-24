extends Container

var currentslot = 1
var freeslot = 1
signal inv1
signal inv2 
signal inv3
signal shkub
func _ready():
		$slot1.color = Color(0,0,0,0.5)
		$slot2.color = Color(0,0,0,0.5)
		$slot3.color = Color(0,0,0,0.5)

func _on_InteractRay_KubikInteract():
	$slot1/kubik.visible = true
	if $slot1.color == Color(1,1,1,0.5):
		emit_signal("shkub")
func _physics_process(delta):
	if Input.is_action_just_pressed("inv1"):
		emit_signal("inv1")
		$slot1.color = Color(1,1,1,0.5)
		$slot2.color = Color(0,0,0,0.5)
		$slot3.color = Color(0,0,0,0.5)
	if Input.is_action_just_pressed("inv2"):
		emit_signal("inv2")
		$slot1.color = Color(0,0,0,0.5)
		$slot2.color = Color(1,1,1,0.5)
		$slot3.color = Color(0,0,0,0.5)
	if Input.is_action_just_pressed("inv3"):
		emit_signal("inv3")
		$slot1.color = Color(0,0,0,0.5)
		$slot2.color = Color(0,0,0,0.5)
		$slot3.color = Color(1,1,1,0.5)


func _on_KinematicBody_inv0():
		$slot1.color = Color(0,0,0,0.5)
		$slot2.color = Color(0,0,0,0.5)
		$slot3.color = Color(0,0,0,0.5)
