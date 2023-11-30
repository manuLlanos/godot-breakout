extends RigidBody2D

var speed: int = 300
var direction: Vector2
var velocity: Vector2

@onready var start_position: Vector2 = position


func _ready():
	Globals.connect("increase_ball_speed", increase_speed)
	direction = random_start_direction()
	velocity = direction * speed

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		if "hit" in collider:
			collider.hit()
		# if we hit the top of the paddle, make the direction depend on the
		# distance from center like in the pong game
		if collider.is_in_group("Paddle") and normal.y == -1:
			var distance = position.x - collider.global_position.x
			velocity = speed * normal.rotated(PI/4 * distance/20)
		else:
			velocity = velocity.bounce(normal)

func random_start_direction():
	var dir = Vector2(0, 1)
#	dir = dir.rotated(randf_range(-PI/4, PI/4))
	dir = dir.rotated([-PI/4, PI/4].pick_random())
	return dir

func reset():
	position = start_position
	direction = random_start_direction()
	velocity = direction * speed

func increase_speed():
	speed += 10
	velocity = direction * speed
