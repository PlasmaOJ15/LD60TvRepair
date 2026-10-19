extends Button

@onready var sprite: AnimatedSprite2D = $sprite

func _on_pressed() -> void:
	sprite.play("press")


func _on_sprite_animation_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/tv_repair.tscn")
