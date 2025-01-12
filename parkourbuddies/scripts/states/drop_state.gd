class_name DropState
extends State

# Signals
signal landed

# Variables
@export var object: Player

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	

func _physics_process(_delta: float) -> void:
	object.sprite.play('drop')
	
	if object.grounded:
		landed.emit()

func exit() -> void:
	set_physics_process(false)
