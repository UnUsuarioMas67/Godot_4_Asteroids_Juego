extends Node

@export var game_start_scene: PackedScene
@export var game_over_scene: PackedScene

var entities_layer
var stage_number = 1


func _ready():
	Events.enemy_destroyed.connect(on_enemy_destroyed)
	Events.game_over.connect(on_game_over)
	
	entities_layer = get_tree().get_first_node_in_group("entities_layer")
	
	display_game_start_text()


func display_game_start_text():
	var game_start_instance = game_start_scene.instantiate()
	add_child(game_start_instance)


func on_enemy_destroyed(score_value: int):
	var entities = entities_layer.get_children()
	
	# filters out player, bullets and any nodes that are being freed from the array,
	# so only the remaining enemy objects are left
	var enemies = entities.filter(
		func(e): 
			return not e.is_in_group("player") and not e is Bullet and not e.is_queued_for_deletion()
			)
	
	if enemies.size() == 0:
		Events.stage_cleared.emit(stage_number)
		stage_number += 1


func on_game_over():
	var game_over_instance = game_over_scene.instantiate()
	add_child(game_over_instance)
	
	game_over_instance.tree_exited.connect(on_game_over_tree_exited)


func on_game_over_tree_exited():
	get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
