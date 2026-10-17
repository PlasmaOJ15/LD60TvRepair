extends Node2D

var tvsActive = 0
@onready var tv_1: Node2D = $TV1
@onready var tv_2: Node2D = $TV2
@onready var tv_3: Node2D = $TV3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activateTV(num: int):
	if num == 1:
		tv_1.visible = true
		tv_1.enterFrame()
		tv_1.startGame()
	if num == 2:
		tv_2.visible = true
		tv_2.enterFrame()
		tv_2.startGame()
	if num == 3:
		tv_3.visible = true
		tv_3.enterFrame()
		tv_3.startGame()
		
func addTV():
	tvsActive += 1
	activateTV(tvsActive)
	print("added TV")
