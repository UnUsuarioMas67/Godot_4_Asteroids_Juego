extends Node

const SAVE_FILE_PATH := "user://data.save"

var save_data := {
	"high_score": 0
}


func _ready():
	load_file()


func load_file():
	if !FileAccess.file_exists(SAVE_FILE_PATH):
		return
	
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	save_data = file.get_var()


func save_file():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)


func submit_score(score: int):
	var current_high_score = save_data["high_score"]
	if score > current_high_score:
		save_data["high_score"] = score
	save_file()
