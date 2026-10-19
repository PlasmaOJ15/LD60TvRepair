extends Control
@onready var score: Label = $CanvasLayer/VBoxContainer/score
@onready var _67: AnimatedSprite2D = $"67"
@onready var gasp: AnimatedSprite2D = $gasp
@onready var victory: AnimatedSprite2D = $victory
@onready var look_up: AnimatedSprite2D = $finalScene/lookUp
@onready var walkie_1: AnimatedSprite2D = $walkie1
@onready var walkie_2: AnimatedSprite2D = $finalScene/walkie2

@onready var final_scene: Node2D = $finalScene

func _ready() -> void:
	Global.winner = true
	if Global.greenMode:
		$greenMode.visible = true
	$Ding.play()
	score.text += str(Global.speedrun_time)
	Global.speedrun_time = 0.0
	Global.final_score = 0



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tv_repair.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on__animation_finished() -> void:
	_67.visible = false
	gasp.visible = true
	gasp.play()
	$Gasp.play()


func _on_gasp_animation_finished() -> void:
	gasp.visible = false
	victory.visible = true
	victory.play()
	$Victory.play()
	$victoryTimer.start()

func _on_victory_timer_timeout() -> void:
	victory.visible = false
	walkie_1.visible = true
	walkie_1.play("idle")
	$NextBatch.play()
	$batchTimer.start()


func _on_batch_timer_timeout() -> void:
	walkie_1.play("talk")
	

func _on_next_batch_finished() -> void:
	$Victory.stop()
	walkie_1.visible = false
	final_scene.visible = true
	look_up.play("loop")
	walkie_2.play("idle")
	$staretimer.start()

func _on_staretimer_timeout() -> void:
	look_up.play("look")
	$Falling.play()


func _on_falling_finished() -> void:
	$MetalPipe.play()
	$finalScene/AnimationPlayer.play("tvFall")


func _on_metal_pipe_finished() -> void:
	$CanvasLayer.visible = true
