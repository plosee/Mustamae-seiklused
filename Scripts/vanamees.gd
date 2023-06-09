extends KinematicBody

export var navNodePath:NodePath
onready var navNode:Navigation = get_node(navNodePath)

export var targetPath:NodePath
onready var targetNode:Spatial = get_node(targetPath)

onready var area:Area = $Area
onready var forwardRayCast:RayCast = $ForwardRayCast
onready var floorRayCast:RayCast = $FloorRayCast
onready var areaShape:CylinderShape = $Area/CollisionShape.shape


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
	self.rotation.y = lerp(self.rotation.y, rand_range(-180, 180), 0.1)

func normal_state():
	areaShape.radius = 10
	forwardRayCast.cast_to = Vector3.FORWARD * 10 
	speed = 1	
	
	
func alert_state():
	areaShape.radius = 20
	forwardRayCast.cast_to = Vector3.FORWARD * 20 
	speed = 3

func navigate_to_target(target:Spatial):
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
			vector = forwardRayCast.cast_to * speed
			vector = self.global_transform.basis.xform(vector)
			
			if !floorRayCast.is_colliding():
				rotate_random()
				
			if forwardRayCast.is_colliding():
				rotate_random()
	
											
	move_and_slide(vector, Vector3.UP)

	
func _on_InteractRay_hurtvanamees():
	health = health - 10
	$Hbar3d/Viewport/Hbar2d.value = health
	if health == 0:
		$Particles.emitting = true
		$Pants.hide()
		$Hbar3d.hide()
		$Hbar3d.hide()
		set_process(false)
		yield(get_tree().create_timer(2), "timeout")
		call_deferred("free")
