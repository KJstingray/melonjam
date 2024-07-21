extends Node2D

@onready var room = preload("res://scenes/world/Room.tscn")
@onready var json_string = FileAccess.get_file_as_string("res://res/staticData/presets.json")
@onready var rooms = $Rooms
@onready var label = $Label
@onready var camera = $Camera2D
@onready var healthbar = $Camera2D/HealthBar
@onready var player = $PlayerBody
@onready var trail = $Line2D
@onready var data = JSON.parse_string(json_string)
@onready var timer = $Timer

var map = [1,2,3,4]
var levelState = {
	doors = {
		'r0': []
	},
	cleared = {}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_map()
	initiateEnemies()
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
	
func checkAdj(index, index2):
	var roomOne = rooms.get_children()[index2].global_position
	var roomTwo = rooms.get_children()[index].global_position
	if(abs(abs(roomOne.x) - abs(roomTwo.x)) == 1152 && roomOne.y == roomTwo.y):
		if(roomOne.x > roomTwo.x):
			return [(index2+1) * 4, (index) * 4 + 2]
		else:
			return [(index + 1) * 4, (index2)*4 + 2]
	elif(abs(abs(roomOne.y) - abs(roomTwo.y)) == 864 && roomOne.x == roomTwo.x):
		if(roomOne.y > roomTwo.y):
			return [(index2) * 4 + 1, (index)*4 + 3]
		else:
			return [(index) * 4 + 1, (index2)*4 + 3]
	return []
	
func _on_player_sigil_closed(index):
	trail.createSigil(index)
	
func update_line():
	trail.add_point(player.position)
	trail.updatePolygons()
	if(trail.get_point_count() > (trail.limit + Store.data.i1.value * Store.items.count('i1')) / (1+Store.data.i0.value * Store.items.count('i0'))):
		trail.remove_point(0)
		
func initiateEnemies():
	for child in get_children():
		if child.is_in_group('enemies'):
			child.target = player
			
func generate_map():
	for n in 8:
		# RANDOMISE LOCATION
		var index = (randi() % map.size())
		var roomPosition = rooms.get_children()[floor((map[index] -1)/4)].global_position
		match map[index] % 4:
			1:
				roomPosition.y -= 864
			2:
				roomPosition.x += 1152
			3:
				roomPosition.y += 864
			0:
				roomPosition.x -= 1152
				
		# UPDATE DATA AND CREATE ROOM
		levelState.doors['r' + str(n + 1)] = []
		var newRoom = room.instantiate()
		newRoom.global_position = roomPosition
		newRoom.id = n+1
		newRoom.room_entered.connect(_on_room_entered)
		rooms.add_child(newRoom)
		var opposite = 0
		match map[index] % 4 :
			1:
				opposite = 3
			2:
				opposite = 4
			3:
				opposite = 1
			0:
				opposite = 2
		
		for p in 4:
			if(p + 1 != opposite):
				map.append((n+1)*4 + p + 1)
		map.remove_at(index)
		if(n >=2):
			for a in n+1:
				var doorcheck = checkAdj(n+1, a)
				if(doorcheck.size()):
					for lockedDoor in doorcheck:
						var doorindex = map.find(lockedDoor)
						if doorindex >= 0:
							map.remove_at(doorindex)
	for n in map:
		rooms.get_children()[floor((n -1)/4)].initDoor(n%4)
		levelState.doors["r" + str(floor((n -1)/4))].append((n-1) % 4 + 1)
	assign_layouts()

func assign_layouts():
	var treasureRoom = (randi() % 8)
	for roomIndex in 9:
		if roomIndex == 8:
			rooms.get_children()[0].initLayout(data['e0'])
		elif roomIndex != 0:
			var index = (randi() % 3 + 1)
			var layout = data['l' + str(index)]
			rooms.get_children()[roomIndex].initLayout(layout)
		else:
			rooms.get_children()[0].initLayout(data['l0'])
			

func _on_line_2d_sigil_finished():
	player.cooldown()
	
func _on_player_body_sigil_closed(index):
	trail.createSigil(index)
	
func _on_room_entered(room):
	camera.global_position = room.global_position
	

func _on_room_room_entered(body):
	camera.global_position = body.global_position


func _on_timer_timeout():
	update_line()


func _on_player_body_hurt_update():
	healthbar.hurt()


func _on_player_body_hp_up():
	healthbar.hpUp()
