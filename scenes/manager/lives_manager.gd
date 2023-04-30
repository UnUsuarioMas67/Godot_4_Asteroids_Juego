extends Node
class_name LivesManager

signal lives_changed

@export var player_scene: PackedScene
@export var starting_lives: int = 3

var current_lives: int


func _ready():
	Events.player_died.connect(on_player_died)
	$RespawnTimer.timeout.connect(on_respawn_timer_timeout)
	
	current_lives = starting_lives


func respawn_player():
	if current_lives == 0:
		Events.game_over.emit()
		return
	
	var player_instance = player_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	
	entities_layer.add_child(player_instance)
	
	var viewport_size = player_instance.get_viewport_rect().size
	var viewport_center = viewport_size / 2
	player_instance.global_position = viewport_center


func get_lives() -> int:
	return current_lives


func on_player_died():
	current_lives -= 1
	lives_changed.emit()
	
	$RespawnTimer.start()


func on_respawn_timer_timeout():
	respawn_player()
