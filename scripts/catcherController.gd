extends CharacterBody2D
@onready var node_2d: Node2D = $".."

const SPEED = 300.0

func _physics_process(_delta: float) -> void:
	
	if node_2d.playing == false:
		velocity = Vector2.ZERO;
	else:
		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
