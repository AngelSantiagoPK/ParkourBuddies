class_name JumpState
extends State

signal drop
signal hang
signal wallrun

@export var object: Player
var initial_gravity: float
@export var jump_gravity: float = 1.0

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	initial_gravity = object.gravity
	object.gravity = jump_gravity
	object.velocity +=  Vector2.UP * object.jump_force
	
	object.sprite.play('jump')

func _physics_process(_delta: float) -> void:
	object.check_for_wall()
	object.check_for_ledge()
	if object.can_hang:
		hang.emit()
		
	if not object.can_jump:
		drop.emit()

	if object.jump_timer.is_stopped():
		object.jump_timer.start()
	
	if not Input.is_action_pressed("up"):
		drop.emit()
		return

	if object.can_wallrun:
		if Input.is_action_pressed("left") and object.move_direction == Vector2.LEFT:
			wallrun.emit()
		if Input.is_action_pressed("right") and object.move_direction == Vector2.RIGHT:
			wallrun.emit()
	
	if Input.is_action_pressed("left"):
		object.move_direction = Vector2.LEFT
		object.velocity +=  Vector2.LEFT * object.move_acceleration
	if Input.is_action_pressed("right"):
		object.velocity +=  Vector2.RIGHT * object.move_acceleration
		object.move_direction = Vector2.RIGHT

	

func exit() -> void:
	object.gravity = initial_gravity
	object.jump_timer.stop()
	set_physics_process(false)
