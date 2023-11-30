extends StaticBody2D

# depending on the color, they give a different score
@export var color: String = "green"
var score: int = 1

func _ready():
	match color:
		"green":
			$Sprite2D.modulate = Color(0, 1, 0)
			score = 1
		"yellow":
			$Sprite2D.modulate = Color(1, 1, 0)
			score = 3
		"red":
			$Sprite2D.modulate = Color(1, 0.27, 0.21)
			score = 5
		"top_red":
			$Sprite2D.modulate = Color(1, 0, 0)
			score = 7

func hit():
	Globals.score += score
	Globals.bricks_broken += 1
	queue_free()
