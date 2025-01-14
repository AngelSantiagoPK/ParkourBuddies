class_name IdleState
extends State


# Signals
signal jump
signal run
signal crouch
signal drop

@export var object: Player

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	
	
func _physics_process(_delta: float) -> void:
	if not Input.is_anything_pressed():
		object.add_friction()
		object.sprite.play('idle')
		
		if not object.grounded:
			drop.emit()
		return
	
	if Input.is_action_just_pressed("up"):
		jump.emit()
		return
	if Input.is_action_pressed("down"):
		crouch.emit()
		return
	if Input.is_action_pressed("left"):
		run.emit()
		return
	if Input.is_action_pressed("right"):
		run.emit()
		return

	

func exit() -> void:
	set_physics_process(false)
