class_name RollState
extends State

# Signals
signal roll_completed
@export var object: Player

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)

func _physics_process(_delta: float) -> void:
	object.sprite.play("roll")
	await object.sprite.animation_finished
	roll_completed.emit()

func exit() -> void:
	set_physics_process(false)
