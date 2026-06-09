extends Area2D

@export var current_field = 0
@export var start_field = 0

@export var player_id = 0
@export var base_index = 0
@export var in_base = true

@onready var game = $"../../GameManager"
@onready var dice = $"../../Dice"
@onready var money = $"../../Money"

@onready var fields = get_node("/root/Game/Fields").get_children()
@onready var bases = get_node("/root/Game/Bases").get_children()
@onready var homes = get_node("/root/Game/Homes").get_children()

var pawns_in_home = 0
var pawns_in_base = 0

var steps_taken = 0

const HOME_SIZE = 4

var in_home = false
var home_index = -1

func move_pawn(amount):
	in_base = false

	current_field = (current_field + amount + fields.size()) % fields.size()

	position = fields[current_field].position

func return_to_base():
	in_base = true
	in_home = false
	steps_taken = 0

	var my_base = bases[player_id].get_children()

	position = my_base[base_index].position

	current_field = -1

func leave_base():
	in_base = false

	current_field = start_field

	position = fields[current_field].position

	steps_taken = 0
	check_capture()

func check_capture():
	var pawns = get_parent().get_children()

	for pawn in pawns:

		if pawn == self:
			continue

		if pawn.in_base:
			continue

		if pawn.in_home:
			continue

		if pawn.player_id != player_id:
			if pawn.current_field == current_field:
				pawn.return_to_base()

func finish_move():
	game.end_turn(true, true)
	dice.clear_label()
	
func check_place():
	var pawns = get_parent().get_children()
	pawns_in_home = 0
	for pawn in pawns:
		if pawn.player_id == player_id and pawn.in_home:
			pawns_in_home +=1
			
	if pawns_in_home == 4 and player_id not in game.place:
		game.place[game.plc_index] = player_id
		game.plc_index+=1
		if game.plc_index==4:
			game.end_game()

func _ready():

	if in_base:
		var my_base = bases[player_id].get_children()
		position = my_base[base_index].position
	else:
		current_field = start_field
		position = fields[current_field].position

func _input_event(viewport, event, shape_idx):
	var my_home = homes[player_id].get_children()
	if player_id != game.current_player:
		return
	
	if not game.can_move:
		return

	if !(event is InputEventMouseButton):
		return

	if !event.pressed:
		return


	# WYJŚCIE Z BAZY
	if in_base:
		if game._LPM or game._PPM:
			return
		if game.dice_backward == 1 or game.dice_forward == 8:
			leave_base()
			finish_move()
		else:
			var pawns = get_parent().get_children()
			for pawn in pawns:
				if pawn.player_id == player_id and pawn.in_base:
					pawns_in_base +=1
			
			if pawns_in_base == 4 and game.dice_backward != 1 and game.dice_forward != 8:
				finish_move()
			pawns_in_base=0
		return

	if in_home:
		var pawns = get_parent().get_children()
		pawns_in_home=0
		for pawn in pawns:
			if pawn.player_id == player_id and pawn.in_home:
				pawns_in_home +=1
		print(pawns_in_home)
		if pawns_in_home == 4:
			finish_move()

	# KROK 1 - RUCH DO TYŁU
	if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not in_base and not in_home:
			var new_steps = game.dice_forward
			steps_taken += new_steps
			#Program sprawdza czy pionek zrobił pełne okrążenie jeśli tak -> wchodzi do domku, jeśli nie-> robi normalny ruch
			if steps_taken >= fields.size():
				var home_pos = steps_taken - fields.size()
				if home_pos >= HOME_SIZE:
					steps_taken -= new_steps
					return
				else:
					position = my_home[home_pos].position
					in_home = true
					game.end_turn(true, game._LPM)
					money.distribute_pawn_placement_money(player_id)
					check_place()
			
			else:
				move_pawn(game.dice_forward)
				game.set_dice(0, game.dice_backward)
				game.end_turn(true, game._LPM)
				check_capture()
			
	if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		if not in_base and not in_home:
			var new_steps = game.dice_backward
			steps_taken -= new_steps
			move_pawn(-game.dice_backward)
			game.set_dice(game.dice_forward, 0)
			game.end_turn(game._PPM ,true)
			check_capture()
