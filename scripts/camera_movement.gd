extends Node2D

@onready var camUp: CollisionShape2D = $cameraMoveUp/CollisionShape2D
@onready var camDown: CollisionShape2D = $cameraMoveDown/CollisionShape2D
@onready var camera: Camera2D = $camera

@onready var logic: Node2D = $"../Logic"

var currUp = false

var camPosUp = Vector2(0,-200)
var camPosDown = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if currUp:
		if camera.position.y != camPosUp.y:
			camera.position.y = move_toward(camera.position.y, camPosUp.y, 25)
	else:
		if camera.position.y != camPosDown.y:
			camera.position.y = move_toward(camera.position.y, camPosDown.y, 25)


func _on_camera_move_up_mouse_entered() -> void:
	logic.getTV().playAnim(1)
	camUp.set_deferred("disabled", true)
	camDown.set_deferred("disabled", false)
	currUp = true

func _on_camera_move_down_mouse_entered() -> void:
	logic.getTV().playAnim(0)
	camUp.set_deferred("disabled", false)
	camDown.set_deferred("disabled", true)
	currUp = false
