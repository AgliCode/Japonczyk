extends Node

var valued8 = 0
var valued6 = 0
@onready var label = $Label
@onready var game = $"../GameManager"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	valued6 = randi_range(1, 6)
	valued8 = randi_range(1, 8)
	label.text = "Do przodu: " + str(valued8) + "\n Do tyłu: " + str(valued6)
	game.set_dice(valued8, valued6)
