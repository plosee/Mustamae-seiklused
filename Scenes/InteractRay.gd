extends RayCast3D

var collider = null
signal kubikinteract

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	collider = get_collider()
	if collider != null:
		if collider.is_in_group("kubik1"):
			
