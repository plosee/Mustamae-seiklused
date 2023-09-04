extends Node


# stop looking at this bitch
func _ready():
	$KimuParticles.emitting = true

# culling interactables on interact
func _on_interact_ray_viin():
	$Interactables/viin.call_deferred("free")

func _on_interact_ray_knife():
	$Interactables/knife.call_deferred("free")

func _on_interact_ray_kubikinteract():
	$Interactables/kubik.call_deferred("free")
	
func _on_interact_ray_kubikinteract_2():
	$Interactables/kubik2.call_deferred("free")

func _on_interact_ray_syringe():
	$Interactables/syringe.call_deferred("free")

