extends Node2D

@export var particles: Array[GPUParticles2D]
@export var total_time: float = 5.0

func _ready():
	for particle in particles:
		particle.emitting = true
	await get_tree().create_timer(total_time).timeout
	self.queue_free()
