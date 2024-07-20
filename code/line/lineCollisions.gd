extends Area2D

@onready var sigil = preload("res://scenes/projectiles/SanguineSigil.tscn")
signal creation_finished
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createSigil(index):
	var n = index
	var vectors = []
	while n < get_children().size() - 2:
		vectors.append(get_children()[n].shape.a)
		n += 1
	var instance = sigil.instantiate()
	instance.vectors = vectors
	get_node("/root").add_child(instance)
	creation_finished.emit()
	for child in get_children():
		remove_child(child)
		child.queue_free()
