extends Node2D

@onready var pillar = preload("res://scenes/objects/obstacles/Pillar.tscn")
@onready var treasurePillar = preload("res://scenes/objects/standing/treasurePillar.tscn")
@onready var werewolf = preload("res://scenes/enemies/Werewolf.tscn")
@onready var skull = preload("res://scenes/enemies/Skull.tscn")
@onready var imp = preload("res://scenes/enemies/Imp.tscn")
@onready var itemTemplate = preload("res://scenes/Items/Item.tscn")
@onready var doors = $Doors
@onready var open = $Sprites/doors/open
@onready var closed = $Sprites/doors/closed
@onready var barred = $Sprites/doors/barred
@onready var label = $Label
@onready var enemies = $Enemies
@onready var decorationLayer = $Decors
@onready var itemsLayer = $Items
@export var id = 0
var layout = {}
var openings = [1, 2, 3, 0]
@export var completed = false

signal room_entered(body)
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(id)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func initDoor(door):
	doors.get_children()[door-1].disabled = false
	open.get_children()[door-1].visible = false
	barred.get_children()[door-1].visible = false
	closed.get_children()[door-1].visible = true
	openings.erase(door-1)
	
func initLayout(pickedLayout):
	layout = pickedLayout
	decorate()
	
func lockDoor(index, mode):
	doors.get_children()[index].disabled = mode

func _on_area_2d_body_entered(body):	
		
	if body.is_in_group('player'):
		room_entered.emit(self)
		if id == 0:
			for bar in barred.get_children():
				bar.visible=false
	if body.is_in_group('player') && layout && !completed: 
		for enemy in layout.enemies:
			var newEnemy
			match enemy.left(1):
				'w':
					newEnemy = werewolf.instantiate()
				'i':
					newEnemy = imp.instantiate()
				's':
					newEnemy = skull.instantiate()
					
			newEnemy.global_position.x = (layout.enemies[enemy][0]*64) + 208
			newEnemy.global_position.y = (layout.enemies[enemy][1]*64) + 224
			newEnemy.death.connect(_on_death)
			enemies.call_deferred("add_child", newEnemy)
		var entrypoint = body.global_position
		if entrypoint.x < global_position.x:
			body.global_position.x += 192
		elif entrypoint.y < global_position.y:
			body.global_position.y += 264
		elif entrypoint.y > global_position.y + 864:
			body.global_position.y -= 192
		else:
			body.global_position.x -= 160
		for n in openings:
			call_deferred('lockDoor', n, false)
		call_deferred('initEnemies', body)
			
func initEnemies(body):
	for enemy in enemies.get_children():
		enemy.target = body
		print(enemy)
		print(enemy.target)

func _on_death(body):
	enemies.remove_child(body)
	body.queue_free()
	if enemies.get_child_count() == 0:
		completed = true
		for n in openings:
			call_deferred('lockDoor', n, true)
			barred.get_child(n).visible = false
			
func decorate():
	#FLOOR MAP
	var floorSlots =[]
	for n in 7:
		var row = []
		for z in 12:
			row.append(z)
		floorSlots.append(row)
	if !layout.exit:
		#OBSTACLES
		for item in layout.obstacles:
			var obstacle = pillar.instantiate()
			obstacle.global_position.x = (layout.obstacles[item][0]*64) + 224
			obstacle.global_position.y = (layout.obstacles[item][1]*64) + 208
			decorationLayer.add_child(obstacle)
		#TREASURE
		for treasureItem in layout.treasure:
			var pedestal = treasurePillar.instantiate()
			pedestal.global_position.x = (treasureItem[0]*64) + 224
			pedestal.global_position.y = (treasureItem[1]*64) + 208
			decorationLayer.add_child(pedestal)
			var newItem = itemTemplate.instantiate()
			newItem.global_position.x = (treasureItem[0]*64) + 224
			newItem.global_position.y = (treasureItem[1]*64) + 128
			newItem.id = (randi()% 5)
			itemsLayer.add_child(newItem)
	else:
		
	#WALL DECORATIONS
	for rotation in [ false, true]:
		for n in 5:
			if n != 2 || !openings.has(2 if rotation else 0):
				var wallSlots = 0
				while wallSlots < 4:
					var chance = (randi() % 7)
					match chance:
						0:
							if wallSlots == 0:
								addWallDeco( n, wallSlots, 'full', rotation)
								wallSlots += 4
							else: 
								wallSlots += 1
						1:
							if wallSlots < 2:
								addWallDeco( n, wallSlots, 'half', rotation)
								wallSlots += 2
							else: 
								wallSlots += 1
						2:
							addWallDeco( n, wallSlots, 'quarter', rotation)
							wallSlots += 1
						_:
							wallSlots += 1
						
func addWallDeco( wall, slot, type, rotated):
	var index = (randi() % Store.decorations[type].size())
	var deco = Store.decorations[type]['d'+str(index+1)].instantiate()
	if !rotated:
		deco.global_position.x = 128 + (wall * 192) + slot * 32
		deco.global_position.y = 64
		decorationLayer.add_child(deco)
	else:
		deco.global_position.x = 256 + (wall * 192) - slot * 32
		deco.global_position.y = 800
		deco.set_global_rotation(PI) 
		decorationLayer.add_child(deco)
