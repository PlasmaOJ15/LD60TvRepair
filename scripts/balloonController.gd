extends CharacterBody2D
@onready var node_2d: Node2D = $".."
@onready var bounce_sfx: AudioStreamPlayer2D = $BounceSFX

const SPEED = 300.0
const BOUNCE_SPEED = 70
var GRAVITY_MULT = .07;
var random = RandomNumberGenerator.new()
var maxVelocity = 100.0;

func _physics_process(delta: float) -> void:
	if node_2d.playing == false:
		velocity = Vector2.ZERO;
	else:
		if (velocity.y > maxVelocity):
			velocity.y = maxVelocity;
		
		# Add the gravity.
		velocity += GRAVITY_MULT * get_gravity() * delta

		#bounce	
		var collision_info = move_and_collide(velocity * delta)
		var randomVector = Vector2(random.randf_range(-40, 40), 0);
		var bounceVector = Vector2(0, -BOUNCE_SPEED)
		if collision_info:
			velocity = velocity.bounce(collision_info.get_normal())+bounceVector+randomVector;
			#sfx
			bounce_sfx.play();
