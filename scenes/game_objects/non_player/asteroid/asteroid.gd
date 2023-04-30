extends CharacterBody2D

@export var smaller_asteroid_scene: PackedScene
@export var score_value = 100
@export var min_speed = 25
@export var max_speed = 150
@export_enum("Large", "Medium", "Small") var explosion_sound: String

var speed: float
var direction: float

var min_rotation_speed = 0.005
var max_rotation_speed = 0.5
var rotation_speed: float
var _explosion_sound_effect: AudioStreamWAV

func _ready():
	speed = randf_range(min_speed, max_speed)
	direction = randf_range(0, TAU)
	rotation = randf_range(0, TAU)
	
	velocity = speed * Vector2.RIGHT.rotated(direction)
	rotation_speed = randf_range(min_rotation_speed, max_rotation_speed)
	
	match explosion_sound:
		"Large":
			_explosion_sound_effect = SoundEffect.BANG_LARGE
		"Medium":
			_explosion_sound_effect = SoundEffect.BANG_MEDIUM
		"Small":
			_explosion_sound_effect = SoundEffect.BANG_SMALL			


func _physics_process(delta):
	rotation += rotation_speed * delta
	move_and_slide()


func destroy():
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	
	# spawn two smaller asteroids
	if smaller_asteroid_scene:
		for i in 2:
			var smaller_asteroid_instance = smaller_asteroid_scene.instantiate() as Node2D
			entities_layer.add_child(smaller_asteroid_instance)
			smaller_asteroid_instance.global_position = global_position
	
	if _explosion_sound_effect:
		SoundPlayer.play_sound(_explosion_sound_effect)
	queue_free()
	Events.enemy_destroyed.emit(score_value)
