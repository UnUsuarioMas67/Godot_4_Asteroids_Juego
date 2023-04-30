extends Node
class_name ScoreManager

signal score_changed

var current_score = 0


func  _ready():
	Events.enemy_destroyed.connect(on_enemy_destroyed)
	


func get_score() -> int:
	return current_score


func on_enemy_destroyed(score_value: int):
	current_score += score_value
	score_changed.emit()
	print_debug(current_score)



