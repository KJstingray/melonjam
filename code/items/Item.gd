extends Node2D

@export var id = -1
@onready var sprite = $Sprite2D
@onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready():
	if id >= 0:
		sprite.frame = id
		label.text = Store.data['i' + str(id)].name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group('player'):
		body.itemGained(id)
		call_deferred('queue_free')
