extends Node

@onready var player = $Character/CharacterBody3D

# tapa end ma tean mida ma teen ning ma ei kahetse seda
# kuni ma kahetsen seda
func _physics_process(delta):
	get_tree().call_group("enemy","update_target_location", player.global_transform.origin)
	
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

