extends CharacterBody2D

@onready var node_2d: Node2D = $".."
@onready var bounce_sfx: AudioStreamPlayer = $BounceSFX

var lowest_y := 264.0
var highest_y := -800.0

const SPEED = 300.0
const BOUNCE_SPEED = 90
var GRAVITY_MULT = .03;
var random = RandomNumberGenerator.new()
var maxVelocity = 100.0;

@onready var fall_sound: AudioStreamPlayer = $"../fallSound"

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
			if position.y < -822:
				velocity = velocity.bounce(collision_info.get_normal())+randomVector
			else:
				velocity = velocity.bounce(collision_info.get_normal())+ bounceVector +randomVector
			#sfx
			bounce_sfx.play();
			
	# volume stuff
	var factor = remap(position.y, lowest_y, highest_y, 0.0, 1.0)
	
	fall_sound.pitch_scale = lerp(0.2, 1.0, factor)
	fall_sound.volume_db = linear_to_db(lerp(0.1, 0.5, factor))
