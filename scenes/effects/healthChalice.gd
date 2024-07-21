extends Sprite2D

@onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("shine")

func deplete(reverse):
	print(reverse)
	animation.play("deplete" if !reverse else "shine")
