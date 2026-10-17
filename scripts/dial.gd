extends Node2D

@export var dialVal := self.rotation_degrees

@onready var assets: Node2D = $assets

@onready var aim_proxy: Node2D = $aimProxy

var canClick := false
var isActive := false

var currPos := 0

var snapDivider := 10

func _process(_delta: float) -> void:
	if isActive:
		aim_proxy.look_at(get_global_mouse_position())
		if (int(aim_proxy.rotation_degrees) % 360)/snapDivider != currPos:
			currPos = (int(aim_proxy.rotation_degrees) % 360)/snapDivider
			if (currPos < 0):
				currPos += 360
				aim_proxy.rotation_degrees += 360
			assets.rotation_degrees = currPos * snapDivider
			print(currPos)
	if Input.is_action_just_pressed("interact"):
		print("did a thing")
		print("Can I click? " + str(canClick))
		if canClick:
			print(self.name + "is Active")
			isActive = true
			Global.mouseBusy = true
		elif isActive:
			print(self.name + "is NOT Active")
			isActive = false
		Global.mouseBusy = false

func _on_mouse_entered() -> void:
	canClick = true
	print("can click " + self.name)

func _on_mouse_exited() -> void:
	canClick = false
	print("cannot click " + self.name)
