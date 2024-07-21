extends TextureButton

@onready var label = $Label
@onready var droplet_spawn = $DropletSpawnPath/DropletSpawn
@onready var droplet = $DropletSpawnPath/DropletSpawn/Droplet
@onready var droplet_timer = $DropletSpawnTimer
@export var text = ''
@export var timer_timeout = 7

func _ready():
	label.text = text
	droplet_timer.wait_time = timer_timeout

func _on_mouse_entered():
	label.add_theme_color_override("font_color", Color.html('#a8141d'))

func _on_mouse_exited():
	label.add_theme_color_override("font_color", Color.BLACK)

func _on_droplet_spawn_timer_timeout():
	var droplet_path_progress = randf_range(0, 1)
	var new_wait_time = randf_range(5,10)
	droplet_timer.wait_time = new_wait_time
	droplet_spawn.progress_ratio = droplet_path_progress
	droplet.play("drop")
