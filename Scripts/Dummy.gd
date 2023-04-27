extends Spatial

var health = 100
	
func _on_InteractRay_hurtdummy():
	health = health - 10
	$Jaak/Hbar3d/Viewport/Hbar2d.value = health
	if health == 0:
		$Particles.emitting = true
		$Model.hide()
		yield(get_tree().create_timer(2), "timeout")
		call_deferred("free")

