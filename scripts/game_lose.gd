extends Control
@onready var kicked_out: AnimatedSprite2D = $kickedOut
@onready var door: AnimatedSprite2D = $door

@onready var hit_ground: AudioStreamPlayer2D = $HitGround
@onready var thrown: AudioStreamPlayer2D = $Thrown
@onready var door_close: AudioStreamPlayer2D = $DoorClose

func _ready() -> void:
	Global.speedrun_time = 0.0
	Global.final_score = 0
	thrown.play()
func _on_kicked_out_animation_finished() -> void:
	if kicked_out.animation == "default":
		door.play("close")
		kicked_out.play("hitground")
	elif kicked_out.animation == "hitground":
		hit_ground.play()
		kicked_out.play("loop")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tv_repair.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_door_animation_finished() -> void:
	door_close.play()
