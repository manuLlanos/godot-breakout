extends Node

signal hud_change
signal increase_ball_speed

var paused: bool = false

# later find a way to store/load the highscore between sessions
func _ready():
	load_score()

var highscore: int = 0:
	set(value):
		highscore = value
		hud_change.emit()

var score: int = 0:
	set(value):
		score = value
		hud_change.emit()
		if score > highscore:
			highscore = score
			save_score()

var bricks_broken: int = 0:
	set(value):
		if value % 5 == 0:
			increase_ball_speed.emit()
		bricks_broken = value

var lives: int = 2:
	set(value):
		lives = value
		hud_change.emit()


func pause():
	if not paused:
		paused = true
		Engine.time_scale = 0

func unpause():
	if paused:
		paused = false
		Engine.time_scale = 1

func reset():
	lives = 2
	score = 0
	bricks_broken = 0


func save_score():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	# we are only saving the highscore on this node
	save_game.store_32(highscore)
	
	save_game.close()

func load_score():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	highscore = save_game.get_32()
	
	save_game.close()
