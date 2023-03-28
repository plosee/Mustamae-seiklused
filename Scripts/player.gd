extends KinematicBody

#physic var
var speed = 14
#var fall_acceleration = 75
var velocity = Vector3.ZERO
var gravity = Vector3.DOWN * 1  # strength of gravity

#camera var
var mouseDelta : Vector2 = Vector2()
onready var camera : Camera = get_node("Position3D/Camera")
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
var lookSensitivity : float = 10.0

func _physics_process(delta):
	
	#movement, works
	var direction = Vector3.ZERO

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	print(Vector3.UP)

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed	
	
	# camera, works half
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
	mouseDelta = Vector2()
	
	get_input()


	

func _ready():
	#locks mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  

func _input(event):
	#no clue what this does - Plose
	#we should probably comment this code out instead of adding comments ~ A-1
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

func get_input():
	velocity.x = 0
	velocity.z = 0
	velocity = Vector3()
	if Input.is_action_pressed("move_up"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("move_down"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("strafe_right"):
		velocity += transform.basis.x * speed
	if Input.is_action_pressed("strafe_left"):
		velocity += -transform.basis.x * speed
	#if Input.is_action_pressed("jump"):
		#velocity.y += 10
