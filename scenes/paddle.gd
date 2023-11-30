extends CharacterBody2D

const speed: int = 400
const WIDTH: int = 40
const HEIGHT: int = 10

@onready var start_position: Vector2 = position

func _process(_delta):
	var direction: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	
	velocity = direction * speed
	move_and_slide()

func shrink():
	$CollisionShape2D.shape.size.x = WIDTH/2
	$Sprite2D.region_rect = Rect2(position, Vector2(WIDTH/2, HEIGHT))

func reset_position():
	position = start_position

func reset():
	position = start_position
	$CollisionShape2D.shape.size.x = WIDTH
	$Sprite2D.region_rect = Rect2(position, Vector2(WIDTH, HEIGHT))
