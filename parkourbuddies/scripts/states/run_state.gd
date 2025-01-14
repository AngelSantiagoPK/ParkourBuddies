class_name RunState
extends State

# Signal
signal jump
signal slide
signal stop
signal drop
signal wallrun

# Variables
@export var object: Player
var slide_threshold: float = 50.0

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	object.sprite.play('run')

func _physics_process(_delta: float) -> void:
	if not Input.is_anything_pressed():
		stop.emit()
		return

	if Input.is_action_pressed("left"):
		object.acclerate(Vector2.LEFT)
		object.move_direction = Vector2.LEFT

	if Input.is_action_pressed("right"):
		object.acclerate(Vector2.RIGHT)
		object.move_direction = Vector2.RIGHT
	
	if Input.is_action_pressed("up"):
		jump.emit()
		return

	if Input.is_action_pressed("down") and abs(object.velocity.x) > slide_threshold:
		slide.emit()
		return
	
	if not object.grounded:
		drop.emit()


func exit() -> void:
	set_physics_process(false)
