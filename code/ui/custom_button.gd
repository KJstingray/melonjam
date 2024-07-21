extends Control

@onready var text_anim_player = $TextAnimPlayer
@onready var state_machine: AnimationNodeStateMachinePlayback = $TextAnimationTree["parameters/playback"]
@onready var droplet_spawn = $DropletSpawnPath/DropletSpawn
@onready var droplet = $DropletSpawnPath/DropletSpawn/Droplet
@onready var droplet_timer = $DropletSpawnTimer

var disabled = false
var mouse_over = false

func _on_mouse_entered():
	mouse_over = true
	if not disabled:
		state_machine.travel("hover")

func _on_mouse_exited():
	mouse_over = false
	state_machine.travel("no_hover")

func on_click():
	pass

func _on_droplet_spawn_timer_timeout():
	var droplet_path_progress = randf_range(0, 1);
	var new_wait_time = randf_range(5,10)
	droplet_timer.wait_time = new_wait_time
	droplet_spawn.progress_ratio = droplet_path_progress;
	droplet.play("drop")
	
