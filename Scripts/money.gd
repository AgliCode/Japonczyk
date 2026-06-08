extends Node

@export var player_id = 0

@onready var red = $Red
@onready var blue = $Blue
@onready var green = $Green
@onready var yellow = $Yellow

@onready var pwn = $"../Pawns"
@onready var game = $"../GameManager"

var end_money = 5000
var pawn_placement_money = 1000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func distribute_pawn_placement_money(plyr_id):
	
	if game.pawn_place >0:
		match plyr_id:
			0:
				red.text = str(int($Red.text) + pawn_placement_money)
			1:
				blue.text = str(int($Blue.text) + pawn_placement_money)
			2:
				green.text = str(int($Green.text) + pawn_placement_money)
			3:
				yellow.text = str(int($Yellow.text) + pawn_placement_money)
			_:
				print("Nothing here")
	game.pawn_place -=1
	pawn_placement_money -= 300 

func distribute_end_placement_money():
	while game.plc_index > 0:
		game.plc_index -=1
		match game.place[game.plc_index]:
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
