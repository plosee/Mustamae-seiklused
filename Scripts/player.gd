extends KinematicBody

var speed = 14
const ACCEL_DEFAULT = 7
const ACCEL_AIR = 1
onready var accel = ACCEL_DEFAULT
var gravity = 9.8
var jump = 5
var itemheld = false

var cam_accel = 40
var mouse_sense = 0.1
var snap

var direction = Vector3()
var velocity = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

#inv0 used for stowing
signal inv0

onready var head = $Head
onready var camera = $Head/Camera

func _ready():
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	#get mouse input for camera rotation
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sense))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sense))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(50))

func _process(delta):
	#camera physics interpolation to reduce physics jitter on high refresh-rate monitors
	if Engine.get_frames_per_second() > Engine.iterations_per_second:
		camera.set_as_toplevel(true)
		camera.global_transform.origin = camera.global_transform.origin.linear_interpolate(head.global_transform.origin, cam_accel * delta)
		camera.rotation.y = rotation.y
		camera.rotation.x = head.rotation.x
	else:
		camera.set_as_toplevel(false)
		camera.global_transform = head.global_transform
		
func _physics_process(delta):
	
	if Input.is_action_just_pressed("inv1"):
		if $Inventory/slot1/kubik.visible:
			itemheld = true
		if $Inventory/slot1/kubik.visible == false:
			itemheld = false
	if Input.is_action_just_pressed("inv2"):
		if $Inventory/slot2/placeholder.visible:
			itemheld = true
		if $Inventory/slot2/placeholder.visible == false:
			itemheld = false
	if Input.is_action_just_pressed("inv3"):
		if $Inventory/slot3/kohahoidja.visible:
			itemheld = true
		if $Inventory/slot3/kohahoidja.visible == false:
			itemheld = false
	if Input.is_action_just_pressed("stow"):
		itemheld = false
		$paulbod/vasak2/kubikinhand.visible = false
		emit_signal("inv0")
		
	if itemheld:
		$paulbod/vasak2.rotation_degrees.x = -15
		$paulbod/vasak2.translation.z = -0.7
		
	if !itemheld:
		$paulbod/vasak2.rotation_degrees.x = 90
		$paulbod/vasak2.translation.z = -0.203
	
	#raycast uses camera rotation
#	$InteractRay.rotation.y = camera.rotation.y

	$InteractRay.global_translation = camera.global_translation
	$InteractRay.global_rotation = camera.global_rotation
	$InteractRay.global_scale(Vector3(1,1,1))
	
	
	#get keyboard input
	direction = Vector3.ZERO
	var h_rot = global_transform.basis.get_euler().y
	var f_input = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	var h_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
	
	#jumping and gravity
	if is_on_floor():
		snap = -get_floor_normal()
		accel = ACCEL_DEFAULT
		gravity_vec = Vector3.ZERO
	else:
		snap = Vector3.DOWN
		accel = ACCEL_AIR
		gravity_vec += Vector3.DOWN * gravity * delta
		
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		snap = Vector3.ZERO
#		gravity_vec = Vector3.UP * jump
	
	#make it move
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	movement = velocity + gravity_vec
	
	move_and_slide_with_snap(movement, snap, Vector3.UP)
	
	if Input.is_action_pressed("run"):
		speed = 20
	else:
		speed = 14
	#KIMUMINE FIRST TEST
	if Input.is_action_pressed("mouseinteract") && $Inventory/slot1.color == Color(1,1,1,0.5) && itemheld:
		$Head/Particles.emitting = true
		$paulbod/vasak2.hide()
		$paulbod/vasak2/kubikinhand.hide()
		$paulbod/vasak3.show()
	if Input.is_action_just_released("mouseinteract"):
		$Head/Particles.emitting = false
		if itemheld:
			$paulbod/vasak2.show()
			$paulbod/vasak2/kubikinhand.show()
			$paulbod/vasak3.hide()

func _on_Inventory_inv1():
	if $Inventory/slot1/kubik.visible == true:
		$paulbod/vasak2/kubikinhand.show()
func _on_Inventory_inv2():
	$paulbod/vasak2/kubikinhand.hide()
func _on_Inventory_inv3():
	$paulbod/vasak2/kubikinhand.hide()	
#used for when slot1 is selected and kubik is added to inventory
func _on_Inventory_shkub():
	$paulbod/vasak2/kubikinhand.show()
	$paulbod/vasak2.show()
	
	
