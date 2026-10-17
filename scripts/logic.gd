extends Node2D

@export var debug := false

@onready var repair: Node2D = $"../Repair"
@onready var tv: Node2D = $"../Repair/TV"
@onready var shelf: Node2D = $"../Shelf"

@onready var antenna_l: ColorRect = $debug/antennaL
@onready var antenna_r: ColorRect = $debug/antennaR
@onready var dial_d: ColorRect = $debug/dialD
@onready var dial_u: ColorRect = $debug/dialU

@onready var dial_tick: AudioStreamPlayer2D = $"../dialTick"
@onready var correct_tic: AudioStreamPlayer2D = $"../correctTic"

var tvScene = preload("res://scenes/tv.tscn")

var rng = RandomNumberGenerator.new()

var active := true

var antL := 0
var antR := 0
var dialU := 0
var dialD := 0

var aLT := false
var aRT := false
var dUT := false
var dDT := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	randomizeVals()

func randomizeVals():
	antL = rng.randi_range(0,18)
	antR = rng.randi_range(0,18)
	dialU = rng.randi_range(0,36)
	dialD = rng.randi_range(0,36)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		if tv.getValue(0) == antL:
			antenna_l.color = Color(0.0, 1.0, 0.0, 1.0)
			aLT = true
		else:
			antenna_l.color = Color(1.0, 0.0, 0.0, 1.0)
			aLT = false
			
		if tv.getValue(1) == antR:
			antenna_r.color = Color(0.0, 1.0, 0.0, 1.0)
			aRT = true
		else:
			antenna_r.color = Color(1.0, 0.0, 0.0, 1.0)
			aRT = false
			
		if tv.getValue(2) == dialU:
			dial_u.color = Color(0.0, 1.0, 0.0, 1.0)
			dUT = true
		else:
			dial_u.color = Color(1.0, 0.0, 0.0, 1.0)
			dUT = false
			
		if tv.getValue(3) == dialD:
			dial_d.color = Color(0.0, 1.0, 0.0, 1.0)
			dDT = true
		else:
			dial_d.color = Color(1.0, 0.0, 0.0, 1.0)
			dDT = false
			
		if aLT and aRT and dUT and dDT:
			active = false
	else:
		if tv.position.x <= -1000:
			shelf.addTV()
			tv.queue_free()
			var newTV = tvScene.instantiate()
			tv = newTV
			repair.add_child(newTV)
			repair.position = Vector2(580,499)
			randomizeVals()
			active = true
		else:
			tv.position.x = move_toward(tv.position.x, -1000, 50)
		
		
		
