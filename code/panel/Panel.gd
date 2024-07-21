extends Sprite2D

var health = 3
var maxHealth = 3
@onready var chalice = preload("res://scenes/effects/healthChalice.tscn")

func update():
	if Store.health != health:
		get_child(health - (health - Store.health)).deplete(health < Store.health)
		health = Store.health
		
	if Store.maxhealth != maxHealth:
		var container = chalice.instantiate()
		container.global_position.y -= 24
		container.global_position.x += -48 + 40 * (Store.maxhealth -1)
		add_child(container)
		maxHealth+= 1


