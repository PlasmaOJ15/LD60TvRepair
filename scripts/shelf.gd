extends Node2D

var tvsActive = 0
@onready var tv_1: Node2D = $TV1
@onready var tv_2: Node2D = $TV2
@onready var tv_3: Node2D = $TV3

var tvList
var currTV


@onready var music: AudioStreamPlayer = $music


var tvPositions = [0,400,800]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tvList = [tv_1,tv_2,tv_3]
	music.stream.set_sync_stream_volume(0, -100.0)
	music.stream.set_sync_stream_volume(1, -100.0)
	music.stream.set_sync_stream_volume(2, -100.0)
	music.play()

func _process(delta: float) -> void:
	pass

func activateTV():
	currTV.visible = true
	currTV.enterFrame()
	currTV.startGame()
		
func getInactiveTV():
	var worked = false
	for i in range(tvList.size()):
		if not tvList[i].active:
			currTV = tvList[i]
			worked = true
			break
	return worked
	
func addTV():
	if getInactiveTV() == true:
		tvsActive += 1
		activateTV()
		print("added TV")

func removeTV(tvVal: int):
	music.stream.set_sync_stream_volume(tvsActive-1, -100.0)
	for i in range(tvPositions.size()):
		if i != tvVal and tvList[i].active:
			print(tvList[i].name + " is active!")
			tvList[i].position.x = tvPositions[i]
		else:
			tvList[i].active = false
			tvList[i].position.x = 1500

func _on_simon_says_game_over() -> void:
	removeTV(2)

func _on_balloon_game_game_over() -> void:
	removeTV(1)

func _on_button_game_game_over() -> void:
	removeTV(0)
