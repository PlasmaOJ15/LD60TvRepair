extends Control
@onready var score: Label = $CanvasLayer/VBoxContainer/score

func _ready() -> void:
	score.text += str(Global.speedrun_time)



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tv_repair.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
