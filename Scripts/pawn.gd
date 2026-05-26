extends Area2D

@export var current_field = 0
@export var start_field = 0

@onready var game = $"../../GameManager"
@onready var my_base = bases[player_id].get_children()
@onready var fields = get_node("/root/Game/Fields").get_children()
@onready var bases = get_node("/root/Game/Bases").get_children()

@export var player_id = 0
@export var base_index = 0
@export var in_base = true

func move_pawn(amount):
	current_field = (current_field + amount) % fields.size()
	position = fields[current_field].position

func return_to_base():
	in_base = true
	position = my_base[base_index].position

func check_capture():
	var pawns = get_parent().get_children()
	for pawn in pawns:
		if pawn == self:
			continue
		if pawn.in_base:
			continue
		if pawn.player_id != player_id:
			if pawn.current_field == current_field:
				pawn.return_to_base()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if in_base:
		position = my_base[base_index].position
	else:
		current_field = start_field
		position = fields[current_field].position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			move_pawn(game.dice_value)
