extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@export var enemy_speed : float = 5.0
# funny vars
var current_clocation
var next_location
var new_velocity
# vars for checking the area
var x : bool 
var y : bool

func _physics_process(delta):
	# no clue how this works
	current_clocation = global_transform.origin
	next_location = nav_agent.get_next_path_position()
	new_velocity = (next_location - current_clocation).normalized() * enemy_speed
	
	velocity = velocity.move_toward(new_velocity, .25)
	move_and_slide()
	
func update_target_location(target_location):
	nav_agent.target_position = target_location


# thi9s does not work
# fix some day

#func _on_area_detect_area_entered(area):
#	# while player is in enemy hitbox, -5 hp every secon and todo animaton
#	x = true
#	while x == true:
#		if area.is_in_group("player"):
#			Global.health -= 5
#			print("hurt")
#			enemy_speed = 0
#			await get_tree().create_timer(1).timeout
#			enemy_speed = 5
#
#func _on_area_detect_area_exited(area):
#	x = false
#
#func _on_area_eyes_area_entered(area):
#	# while player is in eyesight, yhe runs at you like a rabid dog
#	y = true
#	while y == true:
#		if area.is_in_group("player"):
#			enemy_speed = 7
#		else:
#			enemy_speed = 0
#
#func _on_area_eyes_area_exited(area):
#	y = false
