extends Node

@export var asteroid_scene: PackedScene

const BASE_ASTEROID_SPAWN_AMOUNT = 3
const ASTEROID_SPAWN_INCREASE = 1

var stage_number: int = 1


func _ready():
	Events.stage_cleared.connect(on_stage_cleared)
	$Timer.timeout.connect(on_timer_timeout)


func spawn_asteroids():
	var asteroid_amount = BASE_ASTEROID_SPAWN_AMOUNT + (ASTEROID_SPAWN_INCREASE * (stage_number - 1))
	var entities_layer = get_tree().get_first_node_in_group("entities_layer") as Node2D
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if !entities_layer:
		return
	
	# we set a radius around the player position where the asteroids wont be able to spawn
	var player_safe_radius = 400
	# get the viewport size
	var viewport_size = entities_layer.get_viewport_rect().size
	
	
	for i in asteroid_amount:
		var asteroid_instance = asteroid_scene.instantiate() as Node2D
		entities_layer.add_child(asteroid_instance)
		
		# pick a random position within the screen
		var spawn_position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
		
		# check if the player is not null
		if player:
			# make sure the spawn position isn't inside of the safe radius
			while(spawn_position.distance_squared_to(player.global_position) < pow(player_safe_radius, 2)):
				# pick a new random position until we get a valid one
				spawn_position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
		
		asteroid_instance.global_position = spawn_position


func on_timer_timeout():
	spawn_asteroids()


func on_stage_cleared(current_stage: int):
	stage_number = current_stage + 1
	$Timer.start()
