extends Node2D

@export var vectors = []
@onready var collision = $Area2D
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	var poly = Polygon2D.new()
	collision.get_children()[0].call_deferred("set_polygon",PackedVector2Array(vectors))
	timer.start()

func _process(delta):
	pass


func _on_timer_timeout():
	call_deferred("queue_free")


func _on_area_2d_area_entered(area):
	print(area.is_in_group('enemy_box'))
	area.hurt(10)
