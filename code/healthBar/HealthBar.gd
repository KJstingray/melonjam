extends Node2D

@onready var chalice = preload("res://scenes/effects/healthChalice.tscn")
@onready var panel = $Panel
# Called when the node enters the scene tree for the first time.
func _ready():
	for hp in Store.maxhealth:
		var container = chalice.instantiate()
		container.global_position.y -= 24
		container.global_position.x += -48 + 40 * hp
		panel.add_child(container)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hurt():
	print('mksdnmcks')
	Store.health -= 1 if Store.health != 0 else 0
	panel.update()
	
func hpUp():
	Store.maxhealth += 1
	panel.update()
