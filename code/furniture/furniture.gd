extends RigidBody2D

@onready var label = $Label
@export var size = 1
@export var maxSpeed = 60
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(linear_velocity)
	if(linear_velocity.x > maxSpeed):
		linear_velocity.x = maxSpeed
	elif(linear_velocity.x < -maxSpeed):
		linear_velocity.x = -maxSpeed
	if(linear_velocity.y > maxSpeed):
		linear_velocity.y = maxSpeed
	elif(linear_velocity.y < -maxSpeed):
		linear_velocity.y = -maxSpeed

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
