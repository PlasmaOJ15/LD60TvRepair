extends Node2D

@onready var d_1: Node2D = $d1
@onready var d_2: Node2D = $d2
@onready var a_1: Node2D = $a1
@onready var a_2: Node2D = $a2
@onready var player_sprite: AnimatedSprite2D = $assets/PlayerSprite
@onready var staticAsset: AnimatedSprite2D = $assets/Static
@onready var static_audio: AudioStreamPlayer2D = $staticAudio

var animInt = 0


func playAnim(animIntA):
	animInt = animIntA
	player_sprite.play("transition")

func disable():
	d_1.isActive = false
	d_2.isActive = false
	a_1.isActive = false
	a_2.isActive = false

func getLeftIsActive():
	return a_1.getIsActive()

func getRightIsActive():
	return d_1.getIsActive() or d_2.getIsActive() or a_2.getIsActive()

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

func staticDisable():
	staticAsset.visible = false
	static_audio.stop()

func _on_player_sprite_animation_finished() -> void:
	if player_sprite.animation == "transition":
		if animInt == 0:
			player_sprite.play("default")
		elif animInt == 1:
			player_sprite.play("lookUp")
