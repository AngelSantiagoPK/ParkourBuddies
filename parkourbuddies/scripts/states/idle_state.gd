class_name IdleState
extends State


# Signals
signal jump
signal run
signal crouch

@export var object: Player

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)

func check_input() -> void:
	if Input.is_action_just_pressed("up"):
		jump.emit()
	if Input.is_action_pressed("down"):
		crouch.emit()
	if Input.is_action_pressed("left"):
		run.emit()
	if Input.is_action_pressed("right"):
		run.emit()
	
	
func _physics_process(_delta: float) -> void:
	object.sprite.play("idle")
	object.add_friction()
	check_input()

func exit() -> void:
	set_physics_process(false)
