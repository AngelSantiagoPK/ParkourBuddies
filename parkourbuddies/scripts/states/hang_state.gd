class_name HangState
extends State

# Signals
signal climbup
signal drop
signal jump

# Variables
@export var object: Player
var initial_gravity: float
var initial_direction: float = 1
@export var grab_delay: float = 0.5
@export var back_eject_force: float = 50.0

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	object.sprite.play('hang')
	initial_direction = object.sprite.scale.x
	initial_gravity = object.gravity
	object.gravity = 0
	object.velocity = Vector2.ZERO
	object.can_jump = true

func _physics_process(_delta: float) -> void:
	await get_tree().create_timer(grab_delay).timeout
	if Input.is_action_pressed("up"):
		jump.emit()
	
	if Input.is_action_pressed("left") and object.move_direction == Vector2.LEFT:
		climbup.emit()
	if Input.is_action_pressed("left") and object.move_direction == Vector2.RIGHT:
		drop.emit()
	if Input.is_action_pressed("right") and object.move_direction == Vector2.RIGHT:
		climbup.emit()
	if Input.is_action_pressed("right") and object.move_direction == Vector2.LEFT:
		drop.emit()

	if Input.is_action_pressed("down"):
		drop.emit()

func exit() -> void:
	object.gravity = initial_gravity
	object.can_hang = false
	set_physics_process(false)
