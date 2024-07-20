extends Node2D

@onready var doors = $Doors
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func initDoor(door):
	doors.get_children()[door-1].disabled = false
