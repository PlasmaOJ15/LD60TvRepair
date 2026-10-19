class_name SignalGroup
extends Node2D
@onready var green: Button = $"../Green"
@onready var blue: Button = $"../Blue"
@onready var red: Button = $"../Red"

var buttonPressed = green;

signal _any_complete

var buttons;
var signalsBinded = false

var _counter: int = 0

func _ready() -> void:
	buttons = [green, blue, red]

func any(signals: Array) -> Button:
	_counter = signals.size()
	
	if _counter == 0:
		return;
		
	if !signalsBinded:
		for i in signals.size():
			signals[i].connect(_on_signal_complete.bind(buttons[i]))
		signalsBinded = true
		
	await _any_complete
	return buttonPressed;
	
func _on_signal_complete(button: Button):
	buttonPressed = button;
	_any_complete.emit()
	
	
