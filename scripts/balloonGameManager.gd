extends Node2D
@onready var catcher: CharacterBody2D = $Catcher
@onready var balloon: CharacterBody2D = $Balloon

@onready var game_over: AudioStreamPlayer = $gameOver
@onready var fall_sound: AudioStreamPlayer = $fallSound

signal gameOver

var playing = false;
	
func _ready() -> void:
	pass

func startGame():
	#reset balloon
	fall_sound.play()
	playing = true;
	catcher.position.x = 0.0;
	catcher.position.y = 87.0;
	balloon.position.x = 0;
	balloon.position.y = -500;
	
func endGame():
	#end game
	fall_sound.stop()
	game_over.play()
	gameOver.emit()
	playing = false;
