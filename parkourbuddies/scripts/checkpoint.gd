class_name Checkpoint
extends Node2D

signal checkpoint_reached(position: Vector2)
signal stage_complete
@export var final_checkpoint: bool = false
@onready var sprite: Sprite2D = %Sprite2D

func _ready() -> void:
	var rect: Rect2 = Rect2(0, 32, 32, 32)
	sprite.set_region_rect(rect)
	
	if final_checkpoint:
		var color: Color = Color.ORANGE_RED
		sprite.modulate = color
		rect = Rect2(32, 0, 32, 32)
		sprite.set_region_rect(rect)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if final_checkpoint:
		stage_complete.emit()
	else:
		checkpoint_reached.emit(self.global_position)
	
