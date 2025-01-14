class_name DropState
extends State

# Signals
signal landed
signal hang

# Variables
@export var object: Player

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	

func _physics_process(_delta: float) -> void:
	object.sprite.play('drop')
	object.check_for_ledge()
	
	if object.grounded:
		landed.emit()
	
	if Input.is_action_pressed("left"):
		object.move_direction = Vector2.LEFT
		object.velocity += Vector2.LEFT * object.move_acceleration

	if Input.is_action_pressed("right"):
		object.move_direction = Vector2.RIGHT
		object.velocity += Vector2.RIGHT * object.move_acceleration
	
	if object.can_hang:
		hang.emit()

func exit() -> void:
	set_physics_process(false)
