extends CharacterBody2D

var SPEED = 100
var TURNING_SPEED = 2
var vectorX = 1
var vectorY = 0
signal sigilClosed(index)
var wait = false
@onready var timer= $SigilTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	#var tween = create_tween().set_trans(Tween.TRANS_SINE)
	#tween.tween_property(self, "rotor", 2*PI , 6)
	pass

func _physics_process(delta):
	if Input.is_action_pressed("turn_right"):
		vectorX += delta * TURNING_SPEED if vectorX < 1 else 0
	if Input.is_action_pressed("turn_left"):
		vectorX -= delta * TURNING_SPEED if vectorX > -1 else 0
	if Input.is_action_pressed("turn_up"):
		vectorY -= delta * TURNING_SPEED if vectorY > -1 else 0
	if Input.is_action_pressed("turn_down"):
		vectorY += delta * TURNING_SPEED if vectorY < 1 else 0
	velocity = SPEED*Vector2(vectorX,vectorY)
	velocity.limit_length(1)
	var collision = move_and_collide(velocity/50)
	if collision:
		print(collision.get_normal())
		vectorX = velocity.bounce(collision.get_normal()).limit_length(1).x
		vectorY = velocity.bounce(collision.get_normal()).limit_length(1).y
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_force(collision.get_normal() * -SPEED/5)
	


func _on_area_2d_body_entered(body):
	print(body)


func _on_path_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(!wait):
		print('cjuu')
		sigilClosed.emit(area_shape_index)
		wait = true


func _on_line_collisions_creation_finished():
	print('chuj')
	timer.start()


func _on_sigil_timer_timeout():
	wait = false
