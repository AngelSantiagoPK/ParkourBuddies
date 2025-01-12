class_name Player
extends CharacterBody2D

@export var gravity: float = 98.0
@export var terminal_velocity: float = 120.0

var move_direction: Vector2
@export var move_acceleration: float = 50.0
@export var move_speed: float = 100.0
@export var move_friction: float = 60.0

var grounded: bool = true
var can_jump: bool = true
@export var jump_force: float = 300.0

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var jump_timer: Timer = %JumpTimer
@onready var coyote_timer: Timer = %CoyoteTimer
@onready var jump_ray: RayCast2D = %JumpRay
@onready var state_machine: StateMachine = %StateMachine
@onready var state_label: Label = %StateLabel

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	check_for_floor()
	add_gravity()
	move_and_slide()

# Movement Physics Funcitons
func acclerate(direction: Vector2):
	if not grounded:
		return
	
	var new_velocity: Vector2 = velocity + direction * move_acceleration
	velocity = new_velocity.limit_length(move_speed)

func add_friction() -> void:
	velocity = velocity.move_toward(Vector2.ZERO, move_friction)

func add_gravity() -> void:
	var gravity_pull = velocity + Vector2.DOWN * gravity
	gravity_pull.limit_length(terminal_velocity)
	velocity = gravity_pull

func check_for_floor() -> void:
	jump_ray.force_raycast_update()
	if jump_ray.is_colliding():
		can_jump = true
		if grounded:
			return
		grounded = true
	else:
		grounded = false

func _on_jump_timer_timeout() -> void:
	can_jump = false

func _on_coyote_timer_timeout() -> void:
	grounded = false
