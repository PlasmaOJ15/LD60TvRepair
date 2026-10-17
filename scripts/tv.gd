extends Node2D

@onready var d_1: Node2D = $d1
@onready var d_2: Node2D = $d2
@onready var a_1: Node2D = $a1
@onready var a_2: Node2D = $a2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
