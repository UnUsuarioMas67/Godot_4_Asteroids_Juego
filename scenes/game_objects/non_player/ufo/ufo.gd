extends CharacterBody2D

const MIN_SPEED = 200.0
const MAX_SPEED = 300.0
const SCORE_VALUE = 500
const Y_MOVE_DIST = 250.0

@onready var collision_component = $CollisionComponent
@onready var blink_effect = $BlinkEffect

var speed
var target_y


func _ready():
	collision_component.invincibility_started.connect(on_invincibility_started)
	collision_component.invincibility_ended.connect(on_invincibility_ended)
	collision_component.start_invincibility()
	
	$YChangeTimer.timeout.connect(on_timer_timeout)
	
	speed = randf_range(MIN_SPEED, MAX_SPEED)
	var direction_x: float = [-1, 1].pick_random()
	velocity.x = speed * direction_x
	
	target_y = global_position.y
	pick_target_y()


func _physics_process(delta):
	velocity.y = sin(Time.get_ticks_msec() * delta * 0.2) * Y_MOVE_DIST
	
	move_and_slide()


func pick_target_y():
	var direction_y: float = [-1, 1].pick_random()
	var viewport_size = get_viewport_rect().size
	
	target_y += Y_MOVE_DIST * direction_y
	target_y = wrapf(target_y, 0, viewport_size.y)


func destroy():
	queue_free()
	Events.enemy_destroyed.emit(SCORE_VALUE)


func on_invincibility_started():
	blink_effect.start()


func on_invincibility_ended():
	blink_effect.stop()


func on_timer_timeout():
	pick_target_y()
