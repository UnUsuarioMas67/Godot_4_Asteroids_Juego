extends CanvasLayer


func _ready():
	%PlayButton.pressed.connect(on_play_button_pressed)
	%ExitButton.pressed.connect(on_exit_button_pressed)
	
	var current_high_score = HighScoreData.save_data["high_score"]
	%HighScore.text = "High Score: " + "%09d" % current_high_score


func on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_exit_button_pressed():
	get_tree().quit()
