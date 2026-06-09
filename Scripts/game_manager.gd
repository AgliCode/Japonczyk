extends Node

@onready var mny = $"../Money"
@onready var koniecgry = $Label

var dice_forward = 0
var dice_backward = 0
var place = [11, 12, 13, 14]
var plc_index = 0
var pawn_place = 3

var can_move = false

var current_player = 0
var player_count = 4
var player_name = "czerwony"
var endgame = false

func _ready() -> void:
	pass # Replace with function body.

func set_dice(valued8, valued6):
	dice_forward = valued8
	dice_backward = valued6
	can_move = true
	
var _PPM
var _LPM
func end_turn(PPM, LPM):
	
	if PPM==true:
		_PPM = PPM
	if LPM==true:
		_LPM = LPM

	if (PPM==true and LPM==true):
		
		_PPM=false
		_LPM=false
		PPM=false
		LPM=false
		can_move = false
		current_player = (current_player + 1) % player_count
		match current_player:
			0:
				player_name = "czerwony"
			1:
				player_name = "niebieski"
			2:
				player_name = "żółty"
			3:
				player_name = "zielony"
			_:
				print("brak takeigo gracza")
		#mny.check_place()
		print("Tura gracza: ", current_player)
func end_game():
	koniecgry.text = "Koniec gry"
	endgame = true
	mny.distribute_end_placement_money()
