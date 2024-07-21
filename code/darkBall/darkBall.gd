extends CharacterBody2D


const RIGHT = Vector2.RIGHT

@export var speed = 0
var vector = Vector2(0,0)
@onready var animation = $Sprite2D/AnimationPlayer

var target = null

func _ready():
	animation.play("fly")
	vector = global_position.direction_to(target.global_position)
	global_rotation = global_position.direction_to(target.global_position).angle()
	
func _physics_process(delta):
	if target:
		velocity = speed *vector
		var collision = move_and_collide(velocity.limit_length(200)/25)
		if collision:
			if collision.get_collider().is_in_group('player'):
				print('hit')
			call_deferred("queue_free")
