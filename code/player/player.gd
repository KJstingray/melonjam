extends CharacterBody2D

@export var SPEED = 100
var TURNING_SPEED = 2
var vectorX = 1
var vectorY = 0
signal sigilClosed(index)
signal hurt_update
signal hp_up
var wait = false
@export var health = 3
@onready var timer= $SigilTimer
@onready var sprite = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	#var tween = create_tween().set_trans(Tween.TRANS_SINE)
	#tween.tween_property(self, "rotor", 2*PI , 6)
	pass

func _physics_process(delta): 
	var turnSpeedEnchanced = SPEED * (1 + (Store.data.i0.value * Store.items.count("i0")))
	if Input.is_action_pressed("turn_right"):
		vectorX += delta * TURNING_SPEED if vectorX < 1 else 0
	if Input.is_action_pressed("turn_left"):
		vectorX -= delta * TURNING_SPEED if vectorX > -1 else 0
	if Input.is_action_pressed("turn_up"):
		vectorY -= delta * TURNING_SPEED if vectorY > -1 else 0
	if Input.is_action_pressed("turn_down"):
		vectorY += delta * TURNING_SPEED if vectorY < 1 else 0
	velocity = SPEED*Vector2(vectorX,vectorY)
	sprite.global_rotation = atan2(vectorY, vectorX) + PI/2

	var collision = move_and_collide(velocity.limit_length(130)/ (50 / (1 + Store.data.i0.value * Store.items.count("i0"))) )
	if collision:
		vectorX = velocity.bounce(collision.get_normal()).limit_length(1).x
		vectorY = velocity.bounce(collision.get_normal()).limit_length(1).y
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_force(collision.get_normal() * -SPEED/5)

func _on_path_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(!wait):
		sigilClosed.emit(area_shape_index)
		wait = true

func hurt():
	hurt_update.emit()

func cooldown():
	timer.start()

func _on_sigil_timer_timeout():
	wait = false
	
func itemGained(id):
	Store.items.append('i' + str(id))
	if('i'+ str(id) == 'i3'):
		hp_up.emit()


