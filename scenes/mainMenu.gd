extends CanvasLayer

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tv_repair_Tutorial.tscn")
	#load game scene


func _on_credits_button_pressed() -> void:
	$Credits.visible=true
	#load credits scene


func _on_quit_button_pressed() -> void:
	get_tree().quit();


func _on_endless_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tv_repair_endless.tscn")


func _on_settings_pressed() -> void:
	$options_menu.visible = true


func _on_green_disabled_pressed() -> void:
	Global.greenMode = false
	$greenMode.visible = false

func _on_green_enabled_pressed() -> void:
	if Global.winner:
		Global.greenMode = true
		$greenMode.visible = true


func _on_back_button_pressed() -> void:
	$options_menu.visible = false


func _on_sfx_button_pressed() -> void:
	$options_menu/option_container/sfx.play()


func _on_credits_back_pressed() -> void:
	$Credits.visible=false
