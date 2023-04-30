extends Node2D

@onready var particles: GPUParticles2D = $GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	particles.one_shot = true
	particles.emitting = true


func _process(delta):
	if not particles.emitting:
		queue_free()
