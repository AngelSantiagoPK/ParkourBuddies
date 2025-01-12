class_name RunState
extends State

# Signal
signal jump
signal slide
signal stop
signal drop

# Variables
@export var object: Player

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	object.sprite.play('run')

func check_input() -> void:
	if Input.is_action_pressed("left"):
		object.acclerate(Vector2.LEFT)
		object.sprite.scale.x = -1

	if Input.is_action_pressed("right"):
		object.acclerate(Vector2.RIGHT)
		object.sprite.scale.x = 1
	
	if Input.is_action_just_pressed("up"):
		jump.emit()

	if Input.is_action_pressed("down"):
		slide.emit()

	if not Input.is_anything_pressed():
		stop.emit()

func _physics_process(_delta: float) -> void:
	if not object.grounded:
		object.coyote_timer.start()
	
	check_input()
	object.sprite.play("run")

func exit() -> void:
	set_physics_process(false)
