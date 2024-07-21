extends CharacterBody2D


const RIGHT = Vector2.RIGHT

@export var speed = 100
@onready var sprite = $Sprite2D
@onready var rayCast = $RayCast
@onready var label = $Label
@onready var effectBlood = $Bloodstream
@export var health = 10
var vector = Vector2(0,0)

var target = null

signal death

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D/AnimationPlayer.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if target:
		velocity = speed*vector
		var collision = move_and_collide(velocity.limit_length(130)/50)
		if collision:
			
			vector.x = velocity.bounce(collision.get_normal()).limit_length(1).x
			vector.y = velocity.bounce(collision.get_normal()).limit_length(1).y
			if collision.get_collider() is RigidBody2D:
				collision.get_collider().apply_force(collision.get_normal() * -speed/5)
		
	
func align():
	vector = global_position.direction_to(target.global_position)



func hurt(amount):
	effectBlood.emitting = true
	health -= amount
	if health <= 0:
		death.emit(self)



func _on_hurtbox_body_entered(body):
	if(body.is_in_group('player')):
		body.hurt()
