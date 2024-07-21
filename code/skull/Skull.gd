extends CharacterBody2D


const RIGHT = Vector2.RIGHT
@onready var ball = preload("res://scenes/projectiles/darkBall.tscn")
@onready var sprite = $Sprite2D
@onready var rayCast = $RayCast
@onready var label = $Label
@onready var effectBlood = $Bloodstream
@onready var timer = $Cooldown
@export var health = 10
var vector = Vector2(0,0)

var target = null

signal death

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D/AnimationPlayer.play("float")
	timer.start()
		
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


func _on_cooldown_timeout():
	var darkBall = ball.instantiate()
	darkBall.global_position = global_position
	darkBall.target = target
	get_node("/root").add_child(darkBall)
