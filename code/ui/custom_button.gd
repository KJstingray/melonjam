extends Control

@onready var bg_anim_player = $BgAnimPlayer
@onready var text_anim_player = $TextAnimPlayer
@onready var state_machine: AnimationNodeStateMachinePlayback = $TextAnimationTree["parameters/playback"]
@onready var droplet_spawn = $DropletSpawnPath/DropletSpawn
@onready var droplet = $DropletSpawnPath/DropletSpawn/Droplet
@export var text: CompressedTexture2D

var disabled = false
var mouse_over = false

func _ready():
	bg_anim_player.play("start")

func _on_mouse_entered():
	mouse_over = true
	if not disabled:
		state_machine.travel("hover")

func _on_mouse_exited():
	mouse_over = false
	state_machine.travel("no_hover")

func on_click():
	bg_anim_player.play("end")

func _on_droplet_spawn_timer_timeout():
	var droplet_path_progress = randf_range(0, 1);
	droplet_spawn.progress_ratio = droplet_path_progress;
	droplet.play("drop")
	
