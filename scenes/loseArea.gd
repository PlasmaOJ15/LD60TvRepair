extends Area2D
@onready var node_2d: Node2D = $".."

func _on_body_entered(other):
		#break tv
		
		#end game
		node_2d.endGame();
