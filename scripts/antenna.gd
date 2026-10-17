extends Node2D

@export var antennaVal := self.rotation_degrees
@export var flippedHand := false

@onready var hand_sprite: AnimatedSprite2D = $assets/handSprite

@onready var assets: Node2D = $assets

@onready var aim_proxy: Node2D = $aimProxy

@onready var dial_tick: AudioStreamPlayer2D = $dialTick

# are you hovering over the antenna
var canClick := false
# are you actively changing the antenna
var isActive := false

var currPos := 90

var snapDivider := 10

func _ready() -> void:
	if flippedHand:
		hand_sprite.flip_h = true
	assets.rotation_degrees = -90

func _process(_delta: float) -> void:
	if isActive:
		# Look at the mouse and do some wacky math, returning a value of
		# 0 - 18
		aim_proxy.look_at(get_global_mouse_position())
		if (int(aim_proxy.rotation_degrees) % 360 + 180)/snapDivider != currPos:
			dial_tick.play()
			if ((int(aim_proxy.rotation_degrees) % 360) < -180):
				aim_proxy.rotation_degrees = -180
			elif ((int(aim_proxy.rotation_degrees) % 360) > 0):
				aim_proxy.rotation_degrees = 0
			currPos = ((int(aim_proxy.rotation_degrees) % 360 + 180)/snapDivider)
			assets.rotation_degrees = (currPos+18) * snapDivider
			print(currPos)
	else:
		hand_sprite.visible = false
	# click interaction
	if Input.is_action_just_pressed("interact"):
		if isActive:
			isActive = false
			Global.mouseBusy = false
		elif canClick:
			isActive = true
			hand_sprite.visible = true
			Global.mouseBusy = true

func getValue() -> int:
	return currPos

func getIsActive():
	return isActive

func _on_area_2d_mouse_entered() -> void:
	canClick = true

func _on_area_2d_mouse_exited() -> void:
	canClick = false
