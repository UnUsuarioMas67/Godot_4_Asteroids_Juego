extends Node2D

@export var bullet_scene: PackedScene
@export_flags_2d_physics var collision_layer
@export var shoot_time = 0.2

@onready var timer = $Timer


func _ready():
	timer.wait_time = shoot_time


func shoot(direction: Vector2, speed: float = 800.0):
	if not timer.is_stopped():
		return
	
	var bullet_instance = bullet_scene.instantiate() as Bullet
	bullet_instance.direction = direction
	bullet_instance.speed = speed
	bullet_instance.set_collision_layer(collision_layer)
	
	owner.get_parent().add_child(bullet_instance)
	bullet_instance.global_position = global_position
	SoundPlayer.play_sound(SoundEffect.FIRE)
	
	timer.start()
