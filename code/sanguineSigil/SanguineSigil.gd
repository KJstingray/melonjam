extends Node2D

@export var vectors = []
@onready var collision = $Area2D
@onready var timer = $Timer
@onready var line = $Line2D
@onready var polygon = $Polygon2D
# Called when the node enters the scene tree for the first time.
func _ready():
	var poly = Polygon2D.new()
	collision.get_children()[0].call_deferred("set_polygon",PackedVector2Array(vectors))
	timer.start()
	line.points = PackedVector2Array(vectors)
	polygon.polygon = PackedVector2Array(vectors)

func _process(delta):
	pass


func _on_timer_timeout():
	call_deferred("queue_free")


func _on_area_2d_area_entered(area):
	if(area.is_in_group('enemy_box')):
		area.get_parent().hurt(10)


func _on_area_2d_body_entered(body):
	print(body)
	if(body.is_in_group('enemies')):
		body.hurt(10 + (Store.data.i2.value * Store.items.count("i2")))
