extends KinematicBody

# phys
var speed = 14
var gravity = 9.8  # strength of gravity
var accel = 5

# Vector3()
var snap = Vector3()
var velocity = Vector3() 
var newton = Vector3() 
var direction = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

#camera var and function
var mouseDelta : Vector2 = Vector2()
onready var camera : Camera = get_node("Position3D/Camera")
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
var lookSensitivity : float = 10.0
func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

func _ready():
	#locks mouse	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  

func _physics_process(delta):

	# camera, works
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
	mouseDelta = Vector2()
	
	# movement
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	var f_input = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	var h_input = Input.get_action_strength("strafe_right") - Input.get_action_strength("strafe_left")
	direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
	# movement smooth, could be interpolate or action_strength
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	movement = velocity + gravity_vec
	
	move_and_slide_with_snap(movement, snap, Vector3.UP)
	
	# gravity
	if not is_on_floor():
		newton.y -= gravity * delta
	move_and_slide(newton, Vector3.UP)
	#Running
	if Input.is_key_pressed(KEY_SHIFT):
		speed = 30
	else:
		speed = 14






