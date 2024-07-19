extends Line2D

var delay = 3
@onready var collisions = $lineCollisions

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func updatePolygons():
	if(points.size()> 1):
		var new_shape = CollisionShape2D.new()
		new_shape.disabled = true
		collisions.add_child(new_shape)
		var segment = SegmentShape2D.new()
		segment.a = points[points.size() -2]
		segment.b = points[points.size() -1]
		new_shape.shape = segment
	if(collisions.get_child_count() >= 30):
		collisions.get_children()[get_child_count() - 30].disabled = false
			
	if(collisions.get_child_count() > 200):
		for n in 3:
			var node = collisions.get_children()[n]
			collisions.remove_child(node)
			node.queue_free()
	#if(delay == 0):
		#var new_area = Area2D.new()
		#add_child(new_area)
		#var new_shape = CollisionShape2D.new()
		#new_area.add_child(new_shape)
		#var rect = RectangleShape2D.new()
		#
		#new_shape.position = (points[get_point_count() -3 ] + points[get_point_count() -1 ]) / 2
		#new_shape.rotation = points[get_point_count() -3 ].direction_to(points[get_point_count() -1 ] ).angle()
		#var length = points[get_point_count() - 5].distance_to(points[get_point_count() -1])
		#rect.extents = Vector2(length / 2, 10)
		#new_shape.shape = rect
		#var overlaps = get_children()[get_children().size() -1 ].get_overlapping_areas()
		#print(overlaps)
		#delay = 3
	#else:
		#delay -= 1
	
