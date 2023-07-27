extends Node3D

func _on_character_kimu():
	Global.KimuPuffDemo += 1
	Global.KimuSmoke = false
	
func _on_interact_ray_kubikrefill():
	pass
	
func _process(delta):
	print(Global.KimuPuffDemo, " kimupuff jarg: ", Global.KimuPuffs)
	if Global.KimuSmoke == true && Global.KimuPuffs > 1:
		$GPUParticles3D.emitting = true
		Global.KimuPuffDemo -= 1
	elif Global.KimuSmoke == false:
		$GPUParticles3D.emitting = false


