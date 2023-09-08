extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@export var enemy_speed : float = 5.0

func _physics_process(delta):
	var current_clocation = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_clocation).normalized() * enemy_speed
	
	velocity = velocity.move_toward(new_velocity, .25)
	move_and_slide()
	
func update_target_location(target_location):
	nav_agent.target_position = target_location
