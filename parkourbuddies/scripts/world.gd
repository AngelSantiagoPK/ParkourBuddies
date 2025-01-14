extends Node2D

@onready var player: Player = $Player
@onready var spawn: Marker2D = $Spawn
@onready var checkpoints: Node2D = %Checkpoints

func _ready() -> void:
	player.dead.connect(on_dead)
	for i in checkpoints.get_children():
		i.checkpoint_reached.connect(on_checkpoint_reached.bind())
		i.stage_complete.connect(on_stage_complete.bind())

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.on_death()

func on_dead() -> void:
	player.global_position = spawn.global_position

func on_checkpoint_reached(checkpoint_ref: Vector2) -> void:
	spawn.global_position = checkpoint_ref


func on_stage_complete() -> void:
	# TODO: Load up next level
	var next_stage_path: String = StageStorageManager.get_next_level()
	get_tree().change_scene_to_file(next_stage_path)
