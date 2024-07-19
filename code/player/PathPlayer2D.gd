extends Node2D

@onready var body = $PlayerBody
@onready var pathArea = $PathArea
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#global_position = body.global_position
	#pathArea.global_position = position
	pass


func _on_area_2d_area_entered(area):
	print(area)
