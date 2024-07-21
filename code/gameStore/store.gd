extends Node

var items = []
var maxhealth = 3
var health = 3
@onready var json_string = FileAccess.get_file_as_string("res://res/staticData/items.json")
@onready var data = JSON.parse_string(json_string)
@onready var decorations = {
	'full':{
		'd1': preload("res://scenes/objects/walls/walls_brick/decor/full/W_grave1.tscn"),
		'd2': preload("res://scenes/objects/walls/walls_brick/decor/full/W_grave2.tscn"),
		'd3': preload("res://scenes/objects/walls/walls_brick/decor/full/W_grave3.tscn"),
		'd4': preload("res://scenes/objects/walls/walls_brick/decor/full/W_grave4.tscn"),
		'd5': preload("res://scenes/objects/walls/walls_brick/decor/full/W_grave5.tscn"),
	},
	'half':{
		'd1': preload("res://scenes/objects/walls/walls_brick/decor/half/W_window4.tscn"),
	},
	'quarter':{
		'd1': preload("res://scenes/objects/walls/walls_brick/decor/quarter/W_window1.tscn"),
		'd2': preload("res://scenes/objects/walls/walls_brick/decor/quarter/W_window2.tscn"),
		'd3': preload("res://scenes/objects/walls/walls_brick/decor/quarter/W_window3.tscn"),
	}
} 

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	items.clear()
