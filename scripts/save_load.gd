extends Node

const SAVEFILE = "./highscore.save"

var highscore: int = 0

func _ready():
	load_score()

func save_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE_READ)
	file.store_32(highscore)

func load_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if FileAccess.file_exists("user://highscore.save"):
		highscore = file.get_32()
