extends CharacterBody3D

@export var navNodePath:NodePath
@onready var navNode:Navigation = get_node(navNodePath)

@export var targetPath:NodePath
@onready var targetNode:Node3D = get_node(targetPath)

@onready var area:Area3D = $Area3D
@onready var forwardRayCast:RayCast3D = $ForwardRayCast
@onready var floorRayCast:RayCast3D = $FloorRayCast
@onready var areaShape:CylinderShape3D = $Area3D/CollisionShape3D.shape


var gravity = 9.8
var speed = 2
var vector:Vector3 = Vector3.ZERO
var navPath = []

var health = 100

func _ready():
	vector = self.global_transform.origin

func rotate_random():	
	vector = Vector3.ZERO	
	self.rotation.x = 0
	self.rotation.z = 0
	self.rotation.y = lerp(self.rotation.y, randf_range(-180, 180), 0.1)

func normal_state():
	areaShape.radius = 10
	forwardRayCast.target_position = Vector3.FORWARD * 10 
	speed = 1	
	
	
func alert_state():
	areaShape.radius = 20
	forwardRayCast.target_position = Vector3.FORWARD * 20 
	speed = 3

func navigate_to_target(target:Node3D):
	targetNode = target
	navPath = navNode.get_simple_path(self.global_transform.origin, target.global_transform.origin)	

func _process(delta):
	if !is_on_floor():
		vector = Vector3.DOWN * gravity
	else:
		var bodies = area.get_overlapping_bodies()
		var foundTarget = false
		
		if bodies.size() > 1:
			for body in bodies:
				if body == targetNode:
					foundTarget = true
			
		if foundTarget:
			alert_state()
			navigate_to_target(targetNode)
		else:
			normal_state()
			navPath = []
				
							
		if navPath.size() > 0:
			for child in $Holder.get_children():
				$Holder.remove_child(child)
								
			for path in navPath:
			
				var direction:Vector3 = path - self.global_transform.origin
				direction = direction.normalized()
				
				vector = direction * speed * 5
				
				if is_equal_approx(self.global_transform.origin.x, path.x) and is_equal_approx(self.global_transform.origin.z, path.z):
					if navPath.size() > 1:
						var nextPath = navPath[1]
						self.look_at(nextPath, Vector3.UP)
					self.rotation.x = 0
					navPath.remove(0)

			
		else:
			vector = forwardRayCast.target_position * speed
			vector = self.global_transform.basis * (vector)
			
			if !floorRayCast.is_colliding():
				rotate_random()
				
			if forwardRayCast.is_colliding():
				rotate_random()
	
											
	set_velocity(vector)
	set_up_direction(Vector3.UP)
	move_and_slide()

	
func _on_InteractRay_hurtvanamees():
	health = health - 10
	$Hbar3d/SubViewport/Hbar2d.value = health
	if health == 0:
		$Particles.emitting = true
		$Pants.hide()
		$Hbar3d.hide()
		$Hbar3d.hide()
		set_process(false)
		await get_tree().create_timer(2).timeout
		call_deferred("free")
