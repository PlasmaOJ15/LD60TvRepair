extends Control

var rng = RandomNumberGenerator.new()
@onready var options_menu: Control = $menu_buttons/options_menu
@onready var sfx: AudioStreamPlayer = $menu_buttons/options_menu/option_container/sfx
@onready var wall: Sprite2D = $menu_buttons/options_menu/Wall

func _on_options_pressed() -> void:
	options_menu.visible = true

func _on_back_button_pressed() -> void:
	options_menu.visible = false

func _on_sfx_button_pressed() -> void:
	sfx.play()


func _on_impact_enabled_pressed() -> void:
	Global.enableFlash()

func _on_impact_disabled_pressed() -> void:
	Global.disableFlash()
