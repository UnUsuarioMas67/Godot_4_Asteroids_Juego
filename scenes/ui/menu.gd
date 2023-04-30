extends CanvasLayer


func _ready():
	%PlayButton.pressed.connect(on_play_button_pressed)
	%ExitButton.pressed.connect(on_exit_button_pressed)


func on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_exit_button_pressed():
	get_tree().quit()
