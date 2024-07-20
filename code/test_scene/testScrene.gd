extends Node2D

@onready var player = $Player
@onready var timer = $Timer
@onready var line = $Line2D
@onready var enemy = $Enemy
var bloodTrailPoints = []
# Called when the node enters the scene tree for the first time.
func _ready():
	enemy.target = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	line.add_point(player.position)
	line.updatePolygons()
	if(line.get_point_count() > 200):
		line.remove_point(0)
	pass


func _on_timer_timeout():
	pass


func _on_area_2d_area_entered(area):
	print('playerenters')


func _on_line_collisions_area_entered(area):
	print('playerenters2')


func _on_player_sigil_closed(index):
	line.createSigil(index)
