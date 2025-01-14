class_name WallrunState
extends State

# Signal
signal jump
signal drop
signal hang

# Variables
@export var object: Player
@export var wallrun_force: float = 60.0
var initial_gravity: float = 1.0
@export var wallrun_gravity: float = 0.0
# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)
	object.sprite.play('drop')
	initial_gravity = object.gravity
	object.gravity = wallrun_gravity
	object.velocity = Vector2.UP * wallrun_force

func _physics_process(_delta: float) -> void:
	object.check_for_ledge()
	object.check_for_wall()
	
	if not object.can_wallrun:
		drop.emit()
	
	if Input.is_action_pressed("up"):
		jump.emit()
	
	if Input.is_action_pressed("down"):
		drop.emit()

func exit() -> void:
	object.gravity = initial_gravity
	set_physics_process(false)
