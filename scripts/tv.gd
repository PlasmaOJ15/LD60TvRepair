extends Node2D

@onready var d_1: Node2D = $d1
@onready var d_2: Node2D = $d2
@onready var a_1: Node2D = $a1
@onready var a_2: Node2D = $a2
@onready var player_sprite: AnimatedSprite2D = $assets/PlayerSprite
@onready var staticAsset: AnimatedSprite2D = $assets/Static
@onready var static_audio: AudioStreamPlayer2D = $staticAudio

var animInt = 0

signal setDial(which: int, value: bool)

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

func setVals(a1, a2, d1, d2):
	a_1.setVal(a1)
	a_2.setVal(a2)
	d_1.setVal(d1)
	d_2.setVal(d2)

func staticDecrease():
	static_audio.volume_db -= 4
	
func staticIncrease():
	static_audio.volume_db += 4

func _on_player_sprite_animation_finished() -> void:
	if player_sprite.animation == "transition":
		if animInt == 0:
			player_sprite.play("default")
		elif animInt == 1:
			player_sprite.play("lookUp")


func _on_d_1_set_to_correct(value: bool) -> void:
	setDial.emit(2, value)


func _on_d_2_set_to_correct(value: bool) -> void:
	setDial.emit(3, value)


func _on_a_1_set_to_correct(value: bool) -> void:
	setDial.emit(0, value)


func _on_a_2_set_to_correct(value: bool) -> void:
	setDial.emit(1, value)
