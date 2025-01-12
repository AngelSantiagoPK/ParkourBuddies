class_name JumpState
extends State

signal drop

@export var object: Player

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)

func check_input() -> void:
	if Input.is_action_pressed("left"):
		object.acclerate(Vector2.LEFT)
	if Input.is_action_pressed("right"):
		object.acclerate(Vector2.RIGHT)

func _physics_process(_delta: float) -> void:
	if not object.can_jump:
		drop.emit()

	if object.jump_timer.is_stopped():
		object.jump_timer.start()

	object.velocity +=  Vector2.UP * object.jump_force
	object.sprite.play('jump')

func exit() -> void:
	set_physics_process(false)
