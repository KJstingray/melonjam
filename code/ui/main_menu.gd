extends Control

@onready var start_button = $StartGame
@onready var leaderboard = $Leaderboard
@onready var exit = $Exit

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and start_button.mouse_over:
		print('dupa')
		start_button.on_click()
		
func _on_leaderboard_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	pass # Replace with function body.
