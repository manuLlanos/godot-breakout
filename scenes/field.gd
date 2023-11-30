extends Node2D

var game_over: bool = false


func _ready():
	Globals.connect("hud_change", update_hud)
	$HUD/GameOverScreen.hide()
	update_hud()


func update_hud():
	$HUD/LifeCounter/VBoxContainer/LivesAmmount.text = str(max(Globals.lives, 0))
	$HUD/ScoreCounter/VBoxContainer/Score.text = str(Globals.score)
	$HUD/HighscoreCounter/VBoxContainer/Highscore.text = str(Globals.highscore)


func _input(_InputEvent):
	if Input.is_action_just_pressed("reset") and game_over:
		Globals.unpause()
		Globals.reset()
		$Ball.reset_speed()
		$Paddle.reset()
		get_tree().reload_current_scene()

func _on_bottom_area_body_entered(_body):
	Globals.lives -= 1
	await get_tree().create_timer(1).timeout
	if Globals.lives >= 0:
		$Ball.reset()
		$Paddle.reset_position()
	else:
		game_over = true
		Globals.pause()
		$HUD/GameOverScreen.show()



func _on_ceiling_ceiling_reached():
	$Paddle.shrink()
