extends Node

var dice_forward = 0
var dice_backward = 0

var can_move = false

var current_player = 0
var player_count = 4

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
	
	print(_PPM)
	print(_LPM)
	if (PPM==true and LPM==true):
		
		_PPM=false
		_LPM=false
		can_move = false
		current_player = (current_player + 1) % player_count
		print(can_move)
		print("Tura gracza: ", current_player)
