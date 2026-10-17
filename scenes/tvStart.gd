extends Node2D

@export var offset := 0

var gameToStart

var enteringFrame := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameToStart = self.get_child(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enteringFrame:
		position.x = move_toward(position.x, 9 + offset, 50)
		if position.x == 9 + offset:
			enteringFrame = false

func enterFrame():
	enteringFrame = true

func startGame():
	gameToStart.startGame()
