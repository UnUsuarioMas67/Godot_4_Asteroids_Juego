extends Node2D

@onready var particles = $Particles
@onready var thrust_gfx = $ThrustGfx
@onready var thrust_sound = $ThrustSound


func _ready():
	$PlayerThrustEffect.start()
	thrust_gfx.hide()
	particles.emitting = false


func start():
	thrust_gfx.show()
	particles.emitting = true
	thrust_sound.play()


func stop():
	thrust_gfx.hide()
	particles.emitting = false
	thrust_sound.stop()
