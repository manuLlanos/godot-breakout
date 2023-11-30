extends CharacterBody2D

const speed: int = 400

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
	$CollisionShape2D.shape.size.x = 20
	$Sprite2D.region_rect = Rect2(position, Vector2(20, 10))

func reset_position():
	position = start_position
