extends CharacterBody2D

var SPEED = 100
var TURNING_SPEED = 2
var vectorX = 1
var vectorY = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#var tween = create_tween().set_trans(Tween.TRANS_SINE)
	#tween.tween_property(self, "rotor", 2*PI , 6)
	pass

func _physics_process(delta):
	if Input.is_action_pressed("turn_right"):
		# rotor += delta
		vectorX += delta * TURNING_SPEED if vectorX < 1 else 0
	if Input.is_action_pressed("turn_left"):
		# rotor += delta
		vectorX -= delta * TURNING_SPEED if vectorX > -1 else 0
	if Input.is_action_pressed("turn_up"):
		# rotor += delta
		vectorY -= delta * TURNING_SPEED if vectorY > -1 else 0
	if Input.is_action_pressed("turn_down"):
		vectorY += delta * TURNING_SPEED if vectorY < 1 else 0
		# rotor += delta
	velocity = SPEED*Vector2(vectorX,vectorY)
	#print(velocity)
	move_and_slide()
	


func _on_area_2d_body_entered(body):
	print(body)
