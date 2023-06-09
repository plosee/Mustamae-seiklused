extends KinematicBody
class_name Player

var speed = 14
const ACCEL_DEFAULT = 7
const ACCEL_AIR = 1
onready var accel = ACCEL_DEFAULT

var gravity = 9.8
var jump = 5
onready var animation_player = get_node("paulbod/AnimationPlayer")
var timeout = 0.3 #Used for stab timer
var kimuheld = false
var kimupuffed = 0
var kimu_in_puffing = false

var health = 100
var healthbarpos

var syringeused 
var syringeeffects = 0

var knifeheld = false
var inv3 = false

var cam_accel = 40
var mouse_sense = 0.1
var snap

var direction = Vector3()
var velocity = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()

#inv0 used for stowing
signal inv0
signal stab # you can guess what this one is for

onready var head = $Head
onready var camera = $Head/Camera

func _ready():
	#kasutasin seda kuna animationite jaoks vaja kätt näha ja kergem
	$paulbod/vasak2.hide()
	
	#hides the cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	$paulbod/vasak2/syringeheld.hide()
	$paulbod/vasak2/kubikinhand.hide()
	$paulbod/vasak2/knifeheld.hide()
	
func _input(event):
	#get mouse input for camera rotation
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sense))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sense))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(50))

func _process(delta):
#	if Input.is_action_just_pressed("debugbutton"):
#		health -= 10
	#print(kimuheld)
	healthbarpos = 5*health
	if health <= 0:
		death()
	#print(healthbarpos)
	$Inventory/HealthBar.value = health
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
	if Input.is_action_just_pressed("stow"):
		$paulbod/vasak2.hide()
		$paulbod/parem.show()
		emit_signal("inv0")
		
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
	
	if f_input != 0 || h_input != 0:
		animation_player.play("legAction")
	else:
		animation_player.play("regAction")
		
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
	
	#KIMU KOOD
	#Showib kõik vajalikud asjad
	if Input.is_action_pressed("mouseinteract") && $Inventory/slot1.color == Color(1,1,1,0.5) && kimuheld && kimupuffed < 101 && $paulbod/vasak3/vedlabar/vedla.rect_size.y > 0:
		kimu_in_puffing = true
		kimupuffed += 1
		$Head/Particles.emitting = false
		$Inventory/HealParticles.emitting = false
		$paulbod/vasak2.hide()
		$paulbod/vasak3.show()
		$paulbod/vasak3/kubikpuff.show()
		$paulbod/vasak3/kimubar.show()
		$paulbod/vasak3/vedlabar.show()
		$paulbod/vasak3/kimubar/bar.rect_size.y += 2
		$paulbod/vasak3/vedlabar/vedla.rect_size.y -= 0.5
		
	if kimuheld == false:
		$paulbod/vasak3.hide()
		$paulbod/vasak3/kubikpuff.hide()
		$paulbod/vasak3/kimubar.hide()
		$paulbod/vasak3/vedlabar.hide()
			
	if Input.is_action_just_released("mouseinteract") && kimu_in_puffing:
		kimu_in_puffing = false
		$paulbod/vasak3.hide()
		if kimuheld:
			$paulbod/vasak2.show()
			$paulbod/vasak2/kubikinhand.show()
			
	if kimupuffed > 0 && kimu_in_puffing == false:
		$Head/Particles.emitting = true
		if health < 100:
			$Inventory/HealParticles.emitting = true
			$Inventory/HealParticles.position.x = 725+healthbarpos
			health += 0.1
		kimupuffed -= 1
		if $paulbod/vasak3/kimubar/bar.rect_size.y > 0:
			$paulbod/vasak3/kimubar/bar.rect_size.y -= 2
			
#Failsafe kui väljahingamise ajal kimud uuesti, et ei cloudiks edasi
	if kimupuffed == 0:
		$Inventory/HealParticles.emitting = false
		$Head/Particles.emitting = false
		$paulbod/vasak3/kimubar.hide()	
#NOA STABB KOOD
	if Input.is_action_just_pressed("mouseinteract") && $paulbod/vasak2/knifeheld.visible:
		$paulbod/vasak2.translate(Vector3.BACK)
		#code here for when colliding with a group called enemy
		emit_signal("stab")
		yield(get_tree().create_timer(timeout), "timeout")				#sleep for 0.3
		$paulbod/vasak2.translate(Vector3.FORWARD)
		
#Syringe code
	if Input.is_action_just_pressed("mouseinteract") && $paulbod/vasak2/syringeheld.visible && !syringeused:
		$paulbod/vasak2.hide()
		$paulbod/injectedhand.show()
	elif Input.is_action_just_released("mouseinteract") && $paulbod/injectedhand.visible:
		yield(get_tree().create_timer(0.3), "timeout")
		$Inventory/slot3/syringe.visible = false
		syringeused = true
		$paulbod/injectedhand.hide()
		syringeeffects = 100
	if syringeeffects > 0:
		health -= 0.1
		#print(syringeeffects)
		speed = 50
		syringeeffects -= 0.5
		$Inventory/slot3/syringebar/drugbar.rect_size.y = (2*syringeeffects)





func _on_Inventory_inv1():
	if $Inventory/slot1/kubik.visible:
		$paulbod/vasak2.show()
		$paulbod/vasak2/kubikinhand.show()
		$paulbod/vasak3/vedlabar.show()
		kimuheld = true
		$paulbod/parem.hide()
	else:
		$paulbod/parem.show()
		$paulbod/vasak2.hide()
			
	$paulbod/vasak2/syringeheld.hide()
	$paulbod/vasak2/knifeheld.hide()
		
func _on_Inventory_inv2():
	kimuheld = false
	if $Inventory/slot2/knife.visible:
		$paulbod/vasak2.show()
		$paulbod/vasak2/knifeheld.show()
		$paulbod/parem.hide()
	else:
		$paulbod/parem.show()
		$paulbod/vasak2.hide()
		
	$paulbod/vasak2/kubikinhand.hide()
	$paulbod/vasak2/syringeheld.hide()
	$paulbod/vasak3.hide()
	
func _on_Inventory_inv3():
	kimuheld = false
	if $Inventory/slot3/syringe.visible:
		syringeused = false
		$paulbod/vasak2.show()
		$paulbod/vasak2/syringeheld.show()
		$paulbod/parem.hide()
	else:
		$paulbod/parem.show()
		$paulbod/vasak2.hide()
		
	$paulbod/vasak2/kubikinhand.hide()
	$paulbod/vasak2/knifeheld.hide()
	$paulbod/vasak3.hide()
#used for when slot1 is selected and kubik is added to inventory
func _on_Inventory_shkub():
	#print("shkub")
	$paulbod/vasak2.show()
	$paulbod/vasak2/kubikinhand.show()
	$paulbod/parem.hide()
	kimuheld = true

func _on_InteractRay_KubikRefill():
	$paulbod/vasak3/vedlabar/vedla.rect_size.y = 200


func _on_InteractRay_Syringe2Interact():
	pass # Replace with function body.
	
func death():
	get_tree().change_scene("res://Scenes/death.tscn")
