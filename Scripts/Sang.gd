extends Spatial


func _ready():
	pass

func _process(delta):
	pass


func _on_SangArea_body_entered(body):
	print(body)
	if body.is_in_group("Player"):
		print("sang")
