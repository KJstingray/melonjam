extends Node

var items = []
var maxhealth = 3
var health = 3
@onready var json_string = FileAccess.get_file_as_string("res://res/staticData/items.json")
@onready var data = JSON.parse_string(json_string)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	items.clear()
