extends Node2D

@export var debug := false

@onready var repair: Node2D = $"../Repair"
@onready var tv: Node2D = $"../Repair/TV"
@onready var shelf: Node2D = $"../Shelf"

@onready var antenna_l: ColorRect = $debug/antennaL
@onready var antenna_r: ColorRect = $debug/antennaR
@onready var dial_d: ColorRect = $debug/dialD
@onready var dial_u: ColorRect = $debug/dialU

var rng = RandomNumberGenerator.new()

var antL := 0
var antR := 0
var dialU := 0
var dialD := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	antL = rng.randi_range(0,18)
	antR = rng.randi_range(0,18)
	dialU = rng.randi_range(0,36)
	dialD = rng.randi_range(0,36)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tv.getValue(0) == antL:
		antenna_l.color = Color(0.0, 1.0, 0.0, 1.0)
	else:
		antenna_l.color = Color(1.0, 0.0, 0.0, 1.0)
		
	if tv.getValue(1) == antR:
		antenna_r.color = Color(0.0, 1.0, 0.0, 1.0)
	else:
		antenna_r.color = Color(1.0, 0.0, 0.0, 1.0)
		
	if tv.getValue(2) == dialU:
		dial_u.color = Color(0.0, 1.0, 0.0, 1.0)
	else:
		dial_u.color = Color(1.0, 0.0, 0.0, 1.0)
		
	if tv.getValue(3) == dialD:
		dial_d.color = Color(0.0, 1.0, 0.0, 1.0)
	else:
		dial_d.color = Color(1.0, 0.0, 0.0, 1.0)
