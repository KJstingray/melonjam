extends Node2D


const RIGHT = Vector2.RIGHT
@export var speed = 100
@onready var sprite = $Sprite2D
@onready var rayCast = $RayCast
@onready var label = $Label
@onready var effectBlood = $Bloodstream
@export var health = 20

var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if target:
		
		rayCast.global_rotation = global_position.direction_to(target.global_position).angle()
		effectBlood.process_material.direction = Vector3(
			global_position.direction_to(target.global_position).x,
			global_position.direction_to(target.global_position).y,
			0
			)
		var movement = RIGHT.rotated(rayCast.global_rotation) * speed * delta
		global_position += movement
	label.text = str(effectBlood.process_material.direction)


func _on_area_2d_hurt_self(amount):
	effectBlood.emitting = true
	health -= amount
	label.text = 'hp' + str(health)
