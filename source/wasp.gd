extends KinematicBody2D

class_name Wasp

const SPEED: float = 1000.0
var direction: Vector2 = Vector2(-1000, -1000)

func _ready():
	MusicPlayer.get_node("Wasp").play()
	randomize()
	
func _process(delta):

	if 1 + (randi() % 100) > 97:
		_change_direction()

func _physics_process(delta):
	move_and_slide(direction)
	pass
	
func _change_direction():
	direction = Vector2(0, 0)
	while direction == Vector2(0,0):
		var rand_y = randi() % 2
		var rand_x = randi() % 2
		
		var rand_y_sign = 1 if (randi() % 2) > 0.5 else -1
		var rand_x_sign = 1 if (randi() % 2) > 0.5 else -1
		
		direction = Vector2(rand_y * rand_y_sign * SPEED, rand_x * rand_x_sign * SPEED)
	
	rotation = direction.angle() + PI
