extends Area2D
@onready var node_2d: Node2D = $".."

func _on_body_entered(body: Node2D) -> void:
	print("end game");
	#break tv
		
	#end game
	node_2d.endGame();
