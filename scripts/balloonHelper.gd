extends SubViewportContainer

@onready var balloon_game: Node2D = $SubViewport/balloonGame

func startGame():
	balloon_game.startGame()
