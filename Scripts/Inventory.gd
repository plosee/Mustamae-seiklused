extends Container

var currentslot = 1

func _ready():
		$slot1.color = Color(0,0,0,0)
		$slot2.color = Color(0,0,0,0)
		$slot3.color = Color(0,0,0,0)
		
func _physics_process(delta):
	if Input.is_action_just_pressed("inv1"):
		$slot1.color = Color(1,1,1,0.5)
		$slot2.color = Color(0,0,0,0)
		$slot3.color = Color(0,0,0,0)
	if Input.is_action_just_pressed("inv2"):
		$slot1.color = Color(0,0,0,0)
		$slot2.color = Color(1,1,1,0.5)
		$slot3.color = Color(0,0,0,0)
	if Input.is_action_just_pressed("inv3"):
		$slot1.color = Color(0,0,0,0)
		$slot2.color = Color(0,0,0,0)
		$slot3.color = Color(1,1,1,0.5)
