extends Spatial

var rng = RandomNumberGenerator.new()
var moveamount = RandomNumberGenerator.new()
var timer = 0
var health = 100


func _ready():
	pass

func _process(delta):
	#print(timer)
	if health > 0:
		if timer < 1:
			timer = timer+delta
		elif timer >= 1:
			_think()
			timer = 0
			emit_signal("stab")
func _think():
	rng.randomize()
	moveamount.randomize()
	#yield(get_tree().create_timer(1),"timeout")
	var movedir = rng.randi_range(0, 9)
	var move = moveamount.randf_range(0,3)
	#print(movedir)
	if movedir < 8:
		$vanamees.translate_object_local(Vector3(move,0,0))
		movedir = 0
	elif movedir == 8:
		$vanamees.rotate_y(90)
		$vanamees.translate_object_local(Vector3(move,0,0))
		movedir = 0
	elif movedir == 9:
		$vanamees.rotate_y(-90)
		$vanamees.translate_object_local(Vector3(move,0,0))
		movedir = 0
	
func _on_InteractRay_hurtvanamees():
	health = health - 10
	$vanamees/Hbar3d/Viewport/Hbar2d.value = health
	if health == 0:
		$vanamees/Particles.emitting = true
		$vanamees/Pants.hide()
		$vanamees/Hbar3d.hide()
		yield(get_tree().create_timer(2), "timeout")
		call_deferred("free")
