class_name SlideState
extends State

# Signals
signal slide_completed
signal slide_canceled
signal jump

@export var object: Player
@export var initial_friciton: float
var enter_speed: Vector2 = Vector2.ZERO
var slide_friciton: float = 5
@onready var body_collision: CollisionShape2D = %BodyCollision

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	object.sprite.play("slide")
	body_collision.set_disabled(true)
	body_collision.set_visible(false)
	initial_friciton = object.move_friction
	object.move_friction = slide_friciton
	

func _physics_process(_delta: float) -> void:
	object.add_friction()
	
	if not Input.is_anything_pressed():
		slide_canceled.emit()
	
	if Input.is_action_just_pressed("up"):
		jump.emit()

	if object.velocity.x == 0:
		slide_completed.emit()

func exit() -> void:
	body_collision.set_disabled(true)
	body_collision.set_visible(false)
	object.move_friction = initial_friciton
	set_physics_process(false)
