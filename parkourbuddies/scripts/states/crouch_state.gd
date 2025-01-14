class_name CrouchState
extends State

# Signals
signal stand_up
signal run

# Variables
@export var object: Player

# References
@onready var body_collision: CollisionShape2D = %BodyCollision

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	object.sprite.play('crouch')
	body_collision.set_disabled(true)
	body_collision.set_visible(false)

func _physics_process(_delta: float) -> void:
	object.velocity = Vector2.ZERO
	
	if !Input.is_action_pressed("down"):
		stand_up.emit()
	
	if Input.is_action_pressed("left"):
		run.emit()
	
	if Input.is_action_pressed("right"):
		run.emit()
	
	object.move_and_slide()

func exit() -> void:
	body_collision.set_disabled(false)
	body_collision.set_visible(true)
	set_physics_process(false)
