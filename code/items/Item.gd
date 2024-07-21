extends Node2D

@export var id = -1
@onready var sprite = $Sprite2D
@onready var label = $Label
@onready var coll = $Area2D/CollisionShape2D
signal picked
# Called when the node enters the scene tree for the first time.
func _ready():
	if id >= 0:
		sprite.frame = id
		label.text = Store.data['i' + str(id)].name


func preview_mode():
	coll.disabled = false
	
	


func _on_area_2d_body_entered(body):
	if body.is_in_group('player'):
		body.itemGained(id)
		picked.emit(id)
		call_deferred('queue_free')
