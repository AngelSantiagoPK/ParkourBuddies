class_name LandingState
extends State

# Signals
signal crouch
signal run
signal roll

# Variables
@export var object: Player

# References
@onready var body_collision: CollisionShape2D = %BodyCollision

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	object.sprite.play("drop")

func _physics_process(_delta: float) -> void:
	var vel: Vector2 = object.velocity
	if vel < Vector2.ZERO and Input.is_action_pressed("down"):
		roll.emit()
	if vel > Vector2.ZERO and Input.is_action_pressed("down"):
		roll.emit()
	
	if Input.is_action_pressed("up"):
		run.emit()
	if Input.is_action_pressed("left"):
		run.emit()
	if Input.is_action_pressed("right"):
		run.emit()
	
	if Input.is_action_pressed("down") and object.velocity.x == 0:
		crouch.emit()

	if not Input.is_anything_pressed():
		crouch.emit()
	

func exit() -> void:
	body_collision.set_disabled(true)
	body_collision.set_visible(true)
	set_physics_process(false)
