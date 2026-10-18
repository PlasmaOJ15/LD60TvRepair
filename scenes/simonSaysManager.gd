extends Node2D
@onready var enter_pattern_timer: Timer = $EnterPatternTimer
@onready var time_until_next_pattern: Timer = $TimeUntilNextPattern
@onready var flash_color_timer: Timer = $FlashColorTimer
@onready var color_rect: ColorRect = $ColorRect
@onready var green: Button = $Green
@onready var blue: Button = $Blue
@onready var red: Button = $Red
@onready var signal_group: SignalGroup = $SignalGroup

@onready var game_ready: AudioStreamPlayer2D = $gameReady
@onready var game_over: AudioStreamPlayer2D = $gameOver

signal gameOver()

var patternLength = 3;
var timeUntilNextPattern = 10;
var random = RandomNumberGenerator.new();
enum colorOptions {
	GREEN,
	BLUE,
	RED
}
var curColor = colorOptions.GREEN;
var colorPatterns = [];

#color button presses
var signals = []
var signalGroup = SignalGroup.new()

func _ready() -> void:
	signals = [
	green.pressed,
	blue.pressed,
	red.pressed
	]
	
func EndGame():
	#stop all timers
	game_over.play()
	enter_pattern_timer.stop()
	flash_color_timer.stop()
	enter_pattern_timer.stop()
	#break tv
	color_rect.visible = true;
	color_rect.color = Color(1.0, 1.0, 1.0, 1.0);

func startGame():
	ResetGame()

func ResetGame():
	RandomizeTimeUntilNextPattern();
	color_rect.visible = true;
	color_rect.color = Color(0.19, 0.19, 0.19, 1.0);
	#start time until next pattern
	time_until_next_pattern.start();
	
func RandomizeTimeUntilNextPattern():
	timeUntilNextPattern = random.randi_range(8, 15);
	time_until_next_pattern.wait_time = timeUntilNextPattern;
	
func RandomizePattern():
	var randomColor1 = random.randi_range(0, 2);
	var randomColor2 = random.randi_range(0, 2);
	var randomColor3 = random.randi_range(0, 2);
	
	colorPatterns = [randomColor1, randomColor2, randomColor3]
	
func ShowPattern():
	RandomizePattern();
	color_rect.visible = true;
	
	#show pattern
	for i in patternLength:
		flash_color_timer.start();
		ShowColor(colorPatterns[i]);
		#wait until timer is done
		await flash_color_timer.timeout
		#show gray inbetween colors
		flash_color_timer.start();
		color_rect.color = Color(0.19, 0.19, 0.19, 1.0);
		await flash_color_timer.timeout
	
	#end after the last timer finishes
	color_rect.visible = false;
	CheckPattern();
	
	
func ShowColor(color):
	match color:
		colorOptions.GREEN:
			color_rect.color = Color(0.0, 1.0, 0.0, 1.0);
		colorOptions.BLUE:
			color_rect.color = Color(0.0, 0.0, 1.0, 1.0);
		colorOptions.RED:
			color_rect.color = Color(1.0, 0.0, 0.0, 1.0);

	
func CheckPattern():
	print(colorPatterns)
	enter_pattern_timer.start();
	var correct = false
	
	#check if the buttons were pressed in the correct order
	#if button pressed, check if button = next in pattern
	
	for i in patternLength:
	
		var button = await signal_group.any(signals)
		match button.name:
			"Green":
				curColor = colorOptions.GREEN;
			"Blue":
				curColor = colorOptions.BLUE;
			"Red":
				curColor = colorOptions.RED;
				
		if colorPatterns[i] == curColor:
			correct = true
		else:
			correct = false
			EndGame();
			break
			
	if correct == true:
		#complete game successfully - stop timer
		enter_pattern_timer.stop()
		#once finished, set time until next pattern is shown
		ResetGame();
	

func _on_enter_pattern_timer_timeout() -> void:
	#break tv
	gameOver.emit()
	EndGame();
	pass


func _on_time_until_next_pattern_timeout() -> void:
	game_ready.play()
	ShowPattern();
	pass
	
	
