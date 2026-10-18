extends Button

enum State { WAITING, ACTIVE, FAILED, CLICKED }
var current_state: State = State.WAITING

@export_category("Button Timer Settings")
@export var time_to_wait: float = 5.0      # Seconds before it wants to be clicked
@export var active_duration: float = 3.0   # Seconds it stays white (wants to be clicked)

@onready var game_ready: AudioStreamPlayer2D = $"../gameReady"
@onready var game_over: AudioStreamPlayer2D = $"../gameOver"

@onready var timer: Timer = $Timer

@onready var button_sprites: AnimatedSprite2D = $"../buttonSprites"
@onready var text_sprites: AnimatedSprite2D = $"../textSprites"

signal gameOver

var rng = RandomNumberGenerator.new()

# checks for timer node before starting
func _ready() -> void:
	rng.randomize()
	pressed.connect(_on_pressed)
	
	if not timer:
		printerr("ERROR: A Timer child node named 'Timer' isn't there :(")
		return
		
	time_to_wait = rng.randi_range(10,20)
	
	timer.one_shot = true
	if not timer.timeout.is_connected(_on_timer_timeout):
		timer.timeout.connect(_on_timer_timeout)


# checks the time for debuging puropses
func _process(_delta: float) -> void:
	pass
	#if not timer.is_stopped():
	#	print("Timer State: ", State.keys()[current_state], " | Timer Time Left: ", snappedf(timer.time_left, 0.1), "s")


# button is waiting to be able to click
func start_waiting() -> void:
	current_state = State.WAITING
	disabled = true                        
	modulate = Color(0.7, 0.7, 0.7)        
	timer.wait_time = time_to_wait
	timer.start()


# button is active and the player can click it
func start_active() -> void:
	current_state = State.ACTIVE
	disabled = false                       
	modulate = Color.WHITE                 
	timer.wait_time = active_duration
	button_sprites.play("default")
	text_sprites.play("pressNow")
	game_ready.play()
	print("CLICK THE BUTTON")
	timer.start()


# the player didn't click the buton in time
func start_failed() -> void:
	gameOver.emit()
	game_over.play()
	current_state = State.FAILED
	disabled = false                       
	modulate = Color.RED                   
	timer.stop()                           


# when the player clicks the button
func start_clicked() -> void:
	current_state = State.CLICKED
	disabled = true                        
	modulate = Color.GREEN     
	button_sprites.play("press")     
	text_sprites.play("default")       
	timer.wait_time = 1.0                  
	timer.start()


# when timer hits zero, check the state and do correct action
func _on_timer_timeout() -> void:
	match current_state:
		State.WAITING:
			start_active()
		State.ACTIVE:
			start_failed()
		State.CLICKED:
			start_waiting()


# when player clicks the button checks to make sure it should do anything based on action
func _on_pressed() -> void:
	if current_state == State.ACTIVE:
		start_clicked()


func _on_button_sprites_animation_finished() -> void:
	if button_sprites.animation == "press":
		button_sprites.play("pressLoop")
