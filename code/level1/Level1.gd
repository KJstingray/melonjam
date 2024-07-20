extends Node2D

@onready var room = preload("res://scenes/world/Room.tscn")
@onready var rooms = $Rooms
@onready var label = $Label
var map = [1,2,3,4]
# Called when the node enters the scene tree for the first time.
func _ready():
	for n in 5:
		print(n)
		var index = (randi() % map.size())
		print('index')
		print(index)
		print('value')
		print(map[index])
		print('room')
		print(floor((map[index] -1)/4))
		var roomPosition = rooms.get_children()[floor((map[index] -1)/4)].global_position
		print(roomPosition)
		match map[index] % 4:
			1:
				roomPosition.y -= 648
			2:
				roomPosition.x += 1152
			3:
				roomPosition.y += 648
			0:
				roomPosition.x -= 1152
		var newRoom = room.instantiate()
		newRoom.global_position = roomPosition
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
		print(map)
		if(n >=2):
			for a in n+1:
				var doorcheck = checkAdj(n+1, a)
				print(doorcheck)
				if(doorcheck.size()):
					for lockedDoor in doorcheck:
						var doorindex = map.find(lockedDoor)
						if doorindex >= 0:
							map.remove_at(doorindex)
		if n==4:
			label.global_position = roomPosition
		
	for n in map:
		rooms.get_children()[floor((n -1)/4)].initDoor(n%4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func checkAdj(index, index2):
	var roomOne = rooms.get_children()[index2].global_position
	var roomTwo = rooms.get_children()[index].global_position
	if(abs(abs(roomOne.x) - abs(roomTwo.x)) == 1152 && roomOne.y == roomTwo.y):
		if(roomOne.x > roomTwo.x):
			return [(index2+1) * 4, (index) * 4 + 2]
		else:
			return [(index + 1) * 4, (index2)*4 + 2]
	elif(abs(abs(roomOne.y) - abs(roomTwo.y)) == 648 && roomOne.x == roomTwo.x):
		if(roomOne.y > roomTwo.y):
			return [(index2) * 4 + 1, (index)*4 + 3]
		else:
			return [(index) * 4 + 1, (index2)*4 + 3]
	return []		
