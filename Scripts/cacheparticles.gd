extends CanvasLayer

var FirstParticlesMaterial = preload("res://Scenes/Object Scenes/vape_particle.tres")


var materials = [
	FirstParticlesMaterial,
]

func _ready():
	for material in materials:
		var particles_instance = Particles.new()
		particles_instance.set_process_material(material)
		particles_instance.set_one_shot(false)
		particles_instance.set_emitting(false)
		self.add_child(particles_instance)
