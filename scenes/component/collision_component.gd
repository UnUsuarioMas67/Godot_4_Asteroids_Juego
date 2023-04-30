extends Area2D
class_name CollisionComponent

signal invincibility_started
signal invincibility_ended
signal impact


@export var invincibility_time = 2.0

@onready var invincibility_timer = $InvincibilityTimer


func _ready():
	area_entered.connect(on_area_entered)
	invincibility_timer.timeout.connect(on_timer_timeout)
	
	invincibility_timer.wait_time = invincibility_time


func start_invincibility():
	var collision_shapes = get_children().filter(func(child): return child is CollisionShape2D or child is CollisionPolygon2D)
	
	for shape in collision_shapes:
		shape.set_deferred("disabled", true)
	
	invincibility_timer.start()
	invincibility_started.emit()


func stop_invincibility():
	var collision_shapes = get_children().filter(func(child): return child is CollisionShape2D or child is CollisionPolygon2D)
	
	for shape in collision_shapes:
		shape.set_deferred("disabled", false)
	
	invincibility_ended.emit()


func on_area_entered(area: Area2D):
	if area.owner is Bullet:
		area.owner.queue_free()
	
	if owner.has_method("destroy"):
		Callable(owner.destroy).call_deferred()
		impact.emit()


func on_timer_timeout():
	stop_invincibility()
