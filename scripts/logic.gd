extends Node2D

@export var debug := false

@onready var repair: Node2D = $"../Repair"
@onready var tv: Node2D = $"../Repair/TV"
@onready var shelf: Node2D = $"../Shelf"

@onready var antenna_l: ColorRect = $debug/antennaL
@onready var antenna_r: ColorRect = $debug/antennaR
@onready var dial_d: ColorRect = $debug/dialD
@onready var dial_u: ColorRect = $debug/dialU

@onready var hands: Node2D = $"../hands"
@onready var hand_l: AnimatedSprite2D = $"../hands/handL"
@onready var hand_r: AnimatedSprite2D = $"../hands/handR"

@onready var correct_tic: AudioStreamPlayer2D = $"../correctTic"

var tvScene = preload("res://scenes/tv.tscn")

var rng = RandomNumberGenerator.new()

var active := true

var enteringFrame := true

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
	tv.setVals.call_deferred(antL, antR, dialU, dialD)
	tv.setDial.connect(getDialValue)

func randomizeVals():
	antL = rng.randi_range(0,18)
	antR = rng.randi_range(0,18)
	dialU = rng.randi_range(0,17)
	dialD = rng.randi_range(0,17)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if tv.getLeftIsActive():
		hand_l.visible = false
	else:
		hand_l.visible = true
		
	if tv.getRightIsActive():
		hand_r.visible = false
	else:
		hand_r.visible = true
		
	if enteringFrame:
		tv.position.x = move_toward(tv.position.x, 580, 50)
		if tv.position.x == 580:
			enteringFrame = false
	if !active:
		if tv.position.x <= -1000:
			shelf.addTV()
			tv.queue_free()
			var newTV = tvScene.instantiate()
			newTV.position = Vector2(1500,499)
			randomizeVals()
			tv = newTV
			repair.add_child(newTV)
			tv.setVals.call_deferred(antL, antR, dialU, dialD)
			tv.setDial.connect(getDialValue)
			Global.mouseBusy = false
			active = true
			enteringFrame = true
		else:
			tv.staticDisable()
			tv.disable()
			tv.position.x = move_toward(tv.position.x, -1000, 50)
			

func getDialValue(index, value):
	if index == 0:
		if value:
			antenna_l.color = Color(0.0, 1.0, 0.0, 1.0)
			tv.staticDecrease()
			aLT = true
		else:
			antenna_l.color = Color(1.0, 0.0, 0.0, 1.0)
			if aLT:
				tv.staticIncrease()
			aLT = false
	if index == 1:
		if value:
			antenna_r.color = Color(0.0, 1.0, 0.0, 1.0)
			tv.staticDecrease()
			aRT = true
		else:
			antenna_r.color = Color(1.0, 0.0, 0.0, 1.0)
			if aRT:
				tv.staticIncrease()
			aRT = false
			
	if index == 2:
		if value:
			dial_u.color = Color(0.0, 1.0, 0.0, 1.0)
			tv.staticDecrease()
			dUT = true
		else:
			dial_u.color = Color(1.0, 0.0, 0.0, 1.0)
			if dUT:
				tv.staticIncrease()
			dUT = false
			
	if index == 3:
		if value:
			dial_d.color = Color(0.0, 1.0, 0.0, 1.0)
			tv.staticDecrease()
			dDT = true
		else:
			dial_d.color = Color(1.0, 0.0, 0.0, 1.0)
			if dDT:
				tv.staticIncrease()
			dDT = false
			
	if aLT and aRT and dUT and dDT:
		active = false
		aLT = false
		aRT = false
		dUT = false
		dDT = false

func getTV():
	return tv
