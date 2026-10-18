extends Node2D

@onready var button: Button = $Button

signal gameOver

func startGame():
	button.start_waiting()

func _on_button_game_over() -> void:
	gameOver.emit()
