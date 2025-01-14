class_name ClimbUpState
extends State

signal climbup_completed

@export var object: Player
var initial_gravity: float
@export var horizontal_offset: float = 15.0
@export var vertical_offset: float = 30.0
@export var climbup_time: float = 0.4

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	initial_gravity = object.gravity
	object.gravity = 0.0
	object.sprite.play('climb_up')
	var new_position: Vector2 = Vector2.ZERO
	new_position.y = object.global_position.y - vertical_offset
	if object.move_direction == Vector2.LEFT:
		new_position.x = object.global_position.x - horizontal_offset
	if object.move_direction == Vector2.RIGHT:
		new_position.x = object.global_position.x + horizontal_offset
	var tween = get_tree().create_tween()
	tween.tween_property(object, "global_position", new_position, climbup_time)
	await tween.finished
	climbup_completed.emit()

func _physics_process(_delta: float) -> void:
	pass

func exit() -> void:
	object.gravity = initial_gravity
	object.jump_timer.stop()
	set_physics_process(false)
