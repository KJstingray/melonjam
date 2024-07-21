extends CharacterBody2D


const RIGHT = Vector2.RIGHT
@export var speed = 100
@onready var sprite = $Sprite2D
@onready var rayCast = $RayCast
@onready var label = $Label
@onready var effectBlood = $Bloodstream
@export var health = 10
var vectorX = 1
var vectorY = -1

signal death(body)

var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D/AnimationPlayer.play("walk")
	rayCast.global_rotation = -PI / 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = speed*Vector2(vectorX,vectorY)
	var collision = move_and_collide(velocity.limit_length(130)/ (50 ))
	if collision:
		vectorX = velocity.bounce(collision.get_normal()).limit_length(1).x
		vectorY = velocity.bounce(collision.get_normal()).limit_length(1).y
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_force(collision.get_normal() * -speed/5)

#func _on_area_2d_hurt_self(amount):
	#effectBlood.emitting = true
	#health -= amount
	#label.text = 'hp' + str(health)
	
func hurt(amount):
	effectBlood.emitting = true
	health -= amount
	if health <= 0:
		print('dead')
		death.emit(self)



func _on_hurtbox_body_entered(body):
	if(body.is_in_group('player')):
		body.hurt()
