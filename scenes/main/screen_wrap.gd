extends Node2D

@export var wrap_radius = 0

var viewport_size
var target: Node2D

func _ready():
	viewport_size = get_viewport_rect().size
	target = owner as Node2D


func _physics_process(delta):
	if not target:
		return
	
	target.global_position.x = wrapf(target.global_position.x, -wrap_radius, viewport_size.x + wrap_radius)
	target.global_position.y = wrapf(target.global_position.y, -wrap_radius, viewport_size.y + wrap_radius)
