extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var walkie_sprite: AnimatedSprite2D = $walkieSprite
@onready var talkie_sprite: AnimatedSprite2D = $talkieSprite
@onready var walkie_talkie: AudioStreamPlayer2D = $walkieTalkie
@onready var walkie_green: AudioStreamPlayer2D = $walkieGreen

var currPos = -1
var tutorialActive = true
var greensterEgg 

func _ready() -> void:
	greensterEgg = Global.greenMode

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and tutorialActive:
		if currPos == -1:
			animation_player.play("slideIn")
		elif greensterEgg:
			greensterEgg = false
			currPos -= 1
			talkie_sprite.visible = true
			walkie_sprite.play("talk")
			$textGreen.visible = true
			walkie_green.play()
		elif currPos == 0:
			$textGreen.visible = false
			talkie_sprite.visible = true
			walkie_sprite.play("talk")
			$text1.visible = true
			walkie_talkie.play()
		elif currPos == 1:
			$text1.visible = false
			$text2.visible = true
			walkie_talkie.play()
		elif currPos == 2:
			tutorialActive = false
			$text2.visible = false
			talkie_sprite.visible = false
			walkie_sprite.play("default")
			animation_player.play("slideOut")
		elif currPos == 3:
			talkie_sprite.visible = true
			walkie_sprite.play("talk")
			$text3.visible = true
			walkie_talkie.play()
		elif currPos == 4:
			$text3.visible = false
			$text4.visible = true
			walkie_talkie.play()
		elif currPos == 5:
			$text4.visible = false
			$text5.visible = true
			walkie_talkie.play()
		elif currPos == 6:
			$text5.visible = false
			$text6.visible = true
			walkie_talkie.play()
		elif currPos == 7:
			tutorialActive = false
			$text6.visible = false
			talkie_sprite.visible = false
			walkie_sprite.play("default")
			animation_player.play("slideOut")
		currPos += 1

func turnOnTutorial():
	$"../cameraMovement/cameraMoveUp/CollisionShape2D".set_deferred("disabled",false)
	$"../screenBlocker".visible = true
	self.visible = true
	tutorialActive = true
	animation_player.play("slideIn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slideOut":
		self.visible = false
