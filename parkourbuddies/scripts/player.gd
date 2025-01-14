class_name Player
extends CharacterBody2D

signal dead

@export var gravity: float = 98.0
@export var terminal_velocity: float = 1200.0

var move_direction: Vector2
@export var move_acceleration: float = 10.0
@export var move_speed: float = 600.0
@export var move_friction: float = 60.0

var grounded: bool = true
var can_jump: bool = true
var can_hang: bool = false
var can_wallrun: bool = false
var hang_position: Vector2
@export var jump_force: float = 100.0

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var jump_timer: Timer = %JumpTimer
@onready var coyote_timer: Timer = %CoyoteTimer
@onready var rays: Node2D = %Rays
@onready var ledge_ray_right: RayCast2D = %LedgeRayRight
@onready var ledge_ray_down: RayCast2D = %LedgeRayDown
@onready var state_label: Label = %StateLabel

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	check_for_floor()
	add_gravity()
	check_move_direction()
	limit_speeds()
	move_and_slide()
	
# Movement Physics Funcitons
func acclerate(direction: Vector2):
	velocity += direction * move_acceleration

func add_friction() -> void:
	velocity += move_friction * -1 * Vector2.ZERO
	velocity = velocity.move_toward(Vector2.ZERO, move_friction)

func limit_speeds() -> void:
	# Manual way of limiting speed in different directions until I improve this.
	if velocity.x > move_speed:
		velocity.x = move_speed
	elif velocity.x < move_speed * -1:
		velocity.x = move_speed * -1
		
	if velocity.y > terminal_velocity:
		velocity.y = terminal_velocity
	elif velocity.y < terminal_velocity * -1:
		velocity.y = terminal_velocity * -1

func check_move_direction() -> void:
	# This flips the character to face the direction of movement
	if move_direction == Vector2.LEFT:
		sprite.scale.x = -2
	else:
		sprite.scale.x = 2

func add_gravity() -> void:
	velocity += Vector2.DOWN * gravity

func check_for_ledge() -> void:
	ledge_ray_down.set_enabled(true)
	ledge_ray_down.force_raycast_update()
	if ledge_ray_down.is_colliding():
		ledge_ray_right.global_position.y = ledge_ray_down.get_collision_point().y - 0.01
		ledge_ray_right.set_enabled(true)
		ledge_ray_right.force_raycast_update()
		if not ledge_ray_right.is_colliding():
			hang_position.y = ledge_ray_right.get_collision_point().y
			can_hang = true
			
	
	ledge_ray_down.set_enabled(false)
	ledge_ray_right.set_enabled(false)

func check_for_wall() -> void:
		ledge_ray_right.set_enabled(true)
		ledge_ray_right.force_raycast_update()
		if ledge_ray_right.is_colliding():
			# TODO: allow wallruns if speed is past a certain amount
			can_wallrun = true
		else:
			can_wallrun = false
			
		ledge_ray_right.set_enabled(false)

func check_for_floor() -> void:
	var collided: bool = false
	
	for ray in rays.get_children():
		ray = ray as RayCast2D
		ray.force_raycast_update()
		if ray.is_colliding():
			collided = true
	
	if collided:
		can_jump = true
		grounded = true
	else:
		if coyote_timer.is_stopped():
			coyote_timer.start()

func on_death() -> void:
	dead.emit()

func _on_jump_timer_timeout() -> void:
	can_jump = false

func _on_coyote_timer_timeout() -> void:
	grounded = false
