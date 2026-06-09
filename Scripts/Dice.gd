extends Node

var valued8 = 0
var valued6 = 0

@onready var label = $Label
@onready var game = $"../GameManager"

func _ready() -> void:
	randomize()
	
func _on_button_pressed() -> void:

	# Nie można rzucać drugi raz w tej samej turze
	if game.can_move or game.endgame:
		return

	valued6 = randi_range(1, 6)
	valued8 = randi_range(1, 8)

	label.text = "Gracz: " + game.player_name
	label.text += "\nDo przodu: " + str(valued8)
	label.text += "\nDo tyłu: " + str(valued6)

	game.set_dice(valued8, valued6)

func clear_label():
	label.text = ""


func _on_button_2_pressed() -> void:
	game.end_turn(true, true)
	clear_label()
