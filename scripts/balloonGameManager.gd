extends Node2D
@onready var catcher: CharacterBody2D = $Catcher
@onready var balloon: CharacterBody2D = $Balloon

@onready var game_over: AudioStreamPlayer2D = $gameOver

signal gameOver

var playing = false;
	
func _ready() -> void:
	pass

func startGame():
	#reset balloon
	playing = true;
	catcher.position.x = 0.0;
	catcher.position.y = 65.0;
	balloon.position.x = -180.0;
	balloon.position.y = 0;
	
func endGame():
	#end game
	game_over.play()
	gameOver.emit()
	playing = false;
