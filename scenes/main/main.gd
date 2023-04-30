extends Node

@onready var entities = $Entities

var stage_number = 1


func _ready():
	Events.enemy_destroyed.connect(on_enemy_destroyed)


func on_enemy_destroyed(score_value: int):
	var entities_array = entities.get_children()
	
	# filters out player, bullets and any nodes that are being freed from the array,
	# so we only get the remaining enemy objects
	var enemies = entities_array.filter(
		func(e): 
			return not e.is_in_group("player") and not e is Bullet and not e.is_queued_for_deletion()
			)
	
	if enemies.size() == 0:
		Events.stage_cleared.emit(stage_number)
		stage_number += 1
