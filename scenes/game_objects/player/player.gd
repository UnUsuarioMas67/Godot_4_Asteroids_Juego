extends CharacterBody2D

const MAX_SPEED = 378.0
const ACCELERATION = 7.083
const FRICTION = 1.33
const TURNING_SPEED = 4.0

@onready var bullet_spawner = $BulletSpawner
@onready var collision_component: CollisionComponent = $CollisionComponent
@onready var blink_effect = $BlinkEffect
@onready var thrust = $Thrust


func _ready():
	collision_component.invincibility_started.connect(on_invincibility_started)
	collision_component.invincibility_ended.connect(on_invincibility_ended)
	
	collision_component.start_invincibility()


func _physics_process(delta):
	var current_direction = Vector2.UP.rotated(rotation)
	
	# acceleration
	if Input.is_action_pressed("accelerate"):
		var target_velocity = current_direction * MAX_SPEED
		velocity = velocity.move_toward(target_velocity, ACCELERATION)
		thrust.start()
	else:
		thrust.stop()
	
	# friction
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	
	# rotate ship
	var turning_axis = Input.get_axis("turn_left", "turn_right")
	rotation += TURNING_SPEED * turning_axis * delta
	
	# shoot
	if Input.is_action_pressed("shoot"):
		bullet_spawner.shoot(current_direction)
	
	move_and_slide()


func destroy():
	SoundPlayer.play_sound(SoundEffect.BANG_MEDIUM)
	queue_free()
	Events.player_died.emit()
	


func on_invincibility_started():
	blink_effect.start()


func on_invincibility_ended():
	blink_effect.stop()

