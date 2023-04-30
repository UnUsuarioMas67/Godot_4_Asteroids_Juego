extends Node2D
class_name Bullet

var speed = 800.0
var direction = Vector2.ZERO


func _ready():
	$LifeTimer.timeout.connect(on_life_timer_timeout)
	rotation = direction.angle()


func set_collision_layer(collision_layer: int):
	$Hitbox.collision_layer = collision_layer


func _physics_process(delta):
	position += speed * direction * delta


func on_life_timer_timeout():
	Callable(queue_free).call_deferred()
