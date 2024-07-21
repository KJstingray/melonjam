extends Control

@onready var start_button = $CustomButtonText

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and start_button.mouse_over:
		print('dupa')
		start_button.on_click()


	



