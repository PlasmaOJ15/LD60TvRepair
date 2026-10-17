extends Node2D

@onready var d_1: Node2D = $d1
@onready var d_2: Node2D = $d2
@onready var a_1: Node2D = $a1
@onready var a_2: Node2D = $a2
@onready var player_sprite: AnimatedSprite2D = $assets/PlayerSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func playAnim(animInt):
	if animInt == 0:
		player_sprite.play("default")
	elif animInt == 1:
		player_sprite.play("lookUp")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func disable():
	d_1.isActive = false
	d_2.isActive = false
	a_1.isActive = false
	a_2.isActive = false

func getLeftIsActive():
	return d_1.getIsActive() or d_2.getIsActive() or a_1.getIsActive()

func getRightIsActive():
	return a_2.getIsActive()

func getValue(item: int) -> int:
	if item == 0 :
		return a_1.getValue()
	elif item == 1 :
		return a_2.getValue()
	elif item == 2 :
		return d_1.getValue()
	elif item == 3 :
		return d_2.getValue()
	return -1
