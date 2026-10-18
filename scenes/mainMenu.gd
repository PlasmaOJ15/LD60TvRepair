extends CanvasLayer

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tv_repair.tscn")
	#load game scene


func _on_credits_button_pressed() -> void:
	pass
	#load credits scene


func _on_quit_button_pressed() -> void:
	get_tree().quit();
