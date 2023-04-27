extends KinematicBody

var path = []
var path_node = 0

var speed = 3
var gogozeppeli = false

var rng1 = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()
var rng3 = RandomNumberGenerator.new()

var rng1_1
var rng2_1
var rng3_1

var vectorimunn

onready var player = $"../../../Character/KinematicBody/Head"
onready var nav = get_parent().get_parent()

func _physics_process(delta):
	rng1.randomize()
	rng2.randomize()
	rng3.randomize()
	
	rng1_1 = rng1.randf_range(0,10)
	rng2_1 = rng2.randf_range(25,40)
	rng3_1 = rng3.randf_range(20,30)
	
	vectorimunn = Vector3(rng1_1,0,rng3_1)
	
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.DOWN)
			
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0
	
func _on_Timer_timeout():
	print(vectorimunn)
	print("timeout")
	
	if gogozeppeli == true:
		move_to(player.global_transform.origin)
		print("ALERT! GOGO")
		
	else:
		move_and_slide(vectorimunn)
		print("oblivious...")

#func _on_Area_body_entered(body):
##	gogozeppeli = true
