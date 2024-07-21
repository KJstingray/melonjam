extends Line2D

var SigilPause = false
signal sigil_finished
@onready var collisions = $lineCollisions

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	
func updatePolygons():
	if(!SigilPause):
		if(points.size()> 1):
			var new_shape = CollisionShape2D.new()
			new_shape.disabled = true
			collisions.add_child(new_shape)
			var segment = SegmentShape2D.new()
			segment.a = points[points.size() -2]
			segment.b = points[points.size() -1]
			new_shape.shape = segment
		if(collisions.get_child_count() >= 70):
			collisions.get_children()[get_child_count() - 70].disabled = false
				
		if(collisions.get_child_count() > 200):
			for n in 3:
				var node = collisions.get_children()[n]
				collisions.remove_child(node)
				node.queue_free()
	
func createSigil(index):
	SigilPause = true
	collisions.createSigil(index)
	print(index)


func _on_line_collisions_creation_finished():
	points = []
	sigil_finished.emit()
	SigilPause = false
	
func _draw():
	var white : Color = Color.RED
	var godot_blue : Color = Color("478cbf")
	
	draw_polyline(points, white, 10)
