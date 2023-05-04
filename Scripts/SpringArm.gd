extends SpringArm

onready var camera:ClippedCamera = $ClippedCamera
var mouse_sensitivity:float = 20

export var nodePathToTrack:NodePath
onready var nodeToTrack:Spatial = get_node(nodePathToTrack)

var next_spring_length:float = self.spring_length

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.add_exception(nodeToTrack)
	
func _process(delta):
	self.transform.origin = nodeToTrack.transform.origin
	self.transform.origin.y = self.transform.origin.y + 2
	
	if next_spring_length < 2:
		next_spring_length = 2
	elif next_spring_length > 100:
		next_spring_length = 100
	
	if next_spring_length != self.spring_length:
		self.spring_length = lerp(self.spring_length, next_spring_length, 0.1)

