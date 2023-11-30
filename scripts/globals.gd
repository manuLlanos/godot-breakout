extends Node

signal hud_change
signal increase_ball_speed

var paused: bool = false

# later find a way to store/load the highscore between sessions
var highscore: int = 0:
	set(value):
		highscore = value
		hud_change.emit()

var score: int = 0:
	set(value):
		score = value
		hud_change.emit()
		if score > highscore:
			SaveLoad.highscore = highscore
			SaveLoad.save_score()
			highscore = score

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
	SaveLoad.load_score()
	highscore = SaveLoad.highscore
