extends Line2D

var delay = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func updatePolygons():
	if(delay == 0):
		var new_area = Area2D.new()
		add_child(new_area)
		var new_shape = CollisionShape2D.new()
		new_area.add_child(new_shape)
		var rect = RectangleShape2D.new()
		
		new_shape.position = (points[get_point_count() -3 ] + points[get_point_count() -1 ]) / 2
		new_shape.rotation = points[get_point_count() -3 ].direction_to(points[get_point_count() -1 ] ).angle()
		var length = points[get_point_count() - 5].distance_to(points[get_point_count() -1])
		rect.extents = Vector2(length / 2, 10)
		new_shape.shape = rect
		var overlaps = get_children()[get_children().size() -1 ].get_overlapping_areas()
		print(overlaps)
		delay = 3
	else:
		delay -= 1
	if(get_child_count() > 200):
		get_children()[0].queue_free()
