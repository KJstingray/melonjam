extends Node2D

@onready var doors = $Doors
@onready var open = $Sprites/doors/open
@onready var closed = $Sprites/doors/closed
@onready var label = $Label
@onready var gp = $GenerationPoint
@export var id = 0
var layout = {}
@onready var werewolf = preload("res://scenes/enemies/Werewolf.tscn")

signal room_entered(body)
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(id)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func initDoor(door):
	doors.get_children()[door-1].disabled = false
	open.get_children()[door-1].visible = false
	closed.get_children()[door-1].visible = true
	
func initLayout(pickedLayout):
	layout = pickedLayout

func _on_area_2d_body_entered(body):	
		
	if body.is_in_group('player') && layout: 
		print(layout)
		for enemy in layout.enemies:
			var newEnemy
			match enemy.left(1):
				'w':
					newEnemy = werewolf.instantiate()
					
					newEnemy.global_position.x =  (layout.enemies[enemy][0]*64) + 208
					newEnemy.global_position.y =  (layout.enemies[enemy][1]*64) + 224
					call_deferred("add_child", newEnemy)
		room_entered.emit(self)
