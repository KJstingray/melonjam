extends Control

@onready var start_button = $CustomButtonText
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _input(event):
	
	if event is InputEventMouseButton and event.is_pressed() and start_button.mouse_over:
		print('dupa')
		start_button.on_click()
