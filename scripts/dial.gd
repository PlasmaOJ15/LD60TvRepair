extends Node2D

@export var dialVal := self.rotation_degrees

@onready var assets: Node2D = $assets

@onready var aim_proxy: Node2D = $aimProxy

@onready var dial_tick: AudioStreamPlayer2D = $dialTick

# are you hovering over the dial
var canClick := false
# are you actively changing the dial
var isActive := false

var currPos := 0

var snapDivider := 10

func _process(_delta: float) -> void:
	if isActive:
		# Look at the mouse and do some wacky math, returning a value of
		# 0 - 36
		aim_proxy.look_at(get_global_mouse_position())
		if (int(aim_proxy.rotation_degrees) % 360)/snapDivider != currPos:
			dial_tick.play()
			currPos = (int(aim_proxy.rotation_degrees) % 360)/snapDivider
			if (currPos < 0):
				currPos += 360
				aim_proxy.rotation_degrees += 360
			assets.rotation_degrees = currPos * snapDivider
	# click interaction
	if Input.is_action_just_pressed("interact"):
		if isActive:
			isActive = false
			Global.mouseBusy = false
		elif canClick:
			isActive = true
			Global.mouseBusy = true

func getValue() -> int:
	return currPos
	

func _on_area_2d_mouse_entered() -> void:
	canClick = true

func _on_area_2d_mouse_exited() -> void:
	canClick = false
