extends Node

var value = 0
@onready var label = $Label
@onready var game = $"../GameManager"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	value = randi_range(1, 6)
	label.text = str(value)
	game.set_dice(value)
