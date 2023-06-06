extends Node3D

var health = 100
	
func _on_InteractRay_hurtdummy():
	health = health - 10
	$Jaak/Hbar3d/SubViewport/Hbar2d.value = health
	if health == 0:
		$Particles.emitting = true
		$Model.hide()
		set_physics_process(false)
		await get_tree().create_timer(2).timeout
		call_deferred("free")

