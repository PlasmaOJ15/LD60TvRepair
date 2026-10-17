extends Node2D

@export var antennaVal := self.rotation_degrees

@onready var assets: Node2D = $assets

@onready var aim_proxy: Node2D = $aimProxy

# are you hovering over the antenna
var canClick := false
# are you actively changing the antenna
var isActive := false

var currPos := 90

var snapDivider := 10

func _ready() -> void:
	assets.rotation_degrees = -90

func _process(_delta: float) -> void:
	if isActive:
		# Look at the mouse and do some wacky math, returning a value of
		# 0 - 18
		aim_proxy.look_at(get_global_mouse_position())
		if (int(aim_proxy.rotation_degrees) % 360)/snapDivider != currPos:
			if ((int(aim_proxy.rotation_degrees) % 360) < -180):
				aim_proxy.rotation_degrees = -180
			elif ((int(aim_proxy.rotation_degrees) % 360) > 0):
				aim_proxy.rotation_degrees = 0
			currPos = ((int(aim_proxy.rotation_degrees) % 360 + 180)/snapDivider)
			assets.rotation_degrees = (currPos+18) * snapDivider
	# click interaction
	if Input.is_action_just_pressed("interact"):
		if canClick:
			isActive = true
			Global.mouseBusy = true
		elif isActive:
			isActive = false
			Global.mouseBusy = false

func getValue() -> int:
	return currPos

func _on_area_2d_mouse_entered() -> void:
	canClick = true

func _on_area_2d_mouse_exited() -> void:
	canClick = false
