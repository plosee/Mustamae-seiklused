extends RayCast


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal SangCut
# Called when the node enters the scene tree for the first time.
func _ready():
	add_exception(owner)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$InteractPrompt.text = " "
	if is_colliding():
		var collider = get_collider()
		if  collider.is_in_group("NPC"):
			$InteractPrompt.text = "Vajuta [E]"
		if  collider.is_in_group("NPC") and Input.is_action_just_pressed("interact"):
			if ("SangArea:" in str(collider)):
				emit_signal("SangCut")
