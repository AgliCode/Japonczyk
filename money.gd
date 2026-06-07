extends Node

@export var player_id = 0

@onready var red = $Red
@onready var blue = $Blue
@onready var green = $Green
@onready var yellow = $Yellow

@onready var pwn = $"../Pawns"
@onready var game = $"../GameManager"

var end_money = 5000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func distribute_pawn_placement_money():
	game.i -=1
	match game.place[game.i]:
		0:
			red.text = str(int($Red.text) + end_money)
		1:
			blue.text = str(int($Blue.text) + end_money)
		2:
			green.text = str(int($Green.text) + end_money)
		3:
			yellow.text = str(int($Yellow.text) + end_money)
		_:
			print("Nothing here")
	end_money -= 1500 

func distribute_end_placement_money():
	while game.i > 0:
		game.i -=1
		match game.place[game.i]:
			0:
				red.text = str(int($Red.text) + end_money)
			1:
				blue.text = str(int($Blue.text) + end_money)
			2:
				green.text = str(int($Green.text) + end_money)
			3:
				yellow.text = str(int($Yellow.text) + end_money)
			_:
				print("Nothing here")
		end_money -= 1500 


func _on_button_pressed() -> void:
	distribute_end_placement_money()
