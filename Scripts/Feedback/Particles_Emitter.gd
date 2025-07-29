class_name ParticlesEmitter
extends GPUParticles2D

func emit(_damage:float):
	restart()
	emitting = true
