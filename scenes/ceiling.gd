extends StaticBody2D
# to narrow the paddle once the ceiling is hit
var ceiling_already_reached: bool = false
signal ceiling_reached

func hit():
	if not ceiling_already_reached:
		ceiling_already_reached = true
		ceiling_reached.emit()
