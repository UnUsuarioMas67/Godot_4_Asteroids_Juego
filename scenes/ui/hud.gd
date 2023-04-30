extends CanvasLayer

@export var score_manager: ScoreManager
@export var lives_manager: LivesManager

@onready var lives_label = %LivesLabel
@onready var score_label = %ScoreLabel


func _ready():
	if score_manager:
		score_manager.score_changed.connect(on_score_changed)
		update_score_label()
	
	if lives_manager:
		lives_manager.lives_changed.connect(on_lives_changed)
		update_lives_label()


func update_score_label():
	score_label.text = "%09d" % score_manager.get_score()


func update_lives_label():
	lives_label.text = ""
	for life in lives_manager.get_lives():
		lives_label.text += "*"


func on_score_changed():
	update_score_label()


func on_lives_changed():
	update_lives_label()
