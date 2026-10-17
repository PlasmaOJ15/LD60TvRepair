extends Node2D

@onready var button: Button = $Button

func startGame():
	button.start_waiting()
