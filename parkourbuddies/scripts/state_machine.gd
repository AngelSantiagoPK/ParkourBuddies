class_name StateMachine
extends Node

@export var object: Player
@export var state: State
var previous_state: State
var STATES = {}
@onready var state_label: Label = %StateLabel

func _ready() -> void:
	for i in self.get_children():
		STATES[i.name.to_lower()] = i as State
	
	change_state(state)
	
	# Idle Signals
	STATES.idle.jump.connect(func (): change_state(STATES.jump))
	STATES.idle.run.connect(func (): change_state(STATES.run))
	STATES.idle.crouch.connect(func (): change_state(STATES.crouch))
	STATES.idle.drop.connect(func (): change_state(STATES.drop))
	# Crouch Signals
	STATES.crouch.stand_up.connect(func (): change_state(STATES.idle))
	STATES.crouch.run.connect(func (): change_state(STATES.run))
	# Run Signals
	STATES.run.jump.connect(func (): change_state(STATES.jump))
	STATES.run.slide.connect(func (): change_state(STATES.slide))
	STATES.run.stop.connect(func (): change_state(STATES.idle))
	STATES.run.drop.connect(func (): change_state(STATES.drop))
	# Jump Signals
	STATES.jump.drop.connect(func (): change_state(STATES.drop))
	STATES.jump.hang.connect(func (): change_state(STATES.hang))
	STATES.jump.wallrun.connect(func (): change_state(STATES.wallrun))
	# Drop Signals
	STATES.drop.landed.connect(func (): change_state(STATES.landing))
	STATES.drop.hang.connect(func (): change_state(STATES.hang))
	# Landing Signals
	STATES.landing.crouch.connect(func (): change_state(STATES.crouch))
	STATES.landing.roll.connect(func (): change_state(STATES.roll))
	STATES.landing.run.connect(func (): change_state(STATES.run))
	# Roll Signals
	STATES.roll.roll_completed.connect(func (): change_state(STATES.run))
	# Slide Signals
	STATES.slide.slide_completed.connect(func (): change_state(STATES.run))
	STATES.slide.slide_canceled.connect(func (): change_state(STATES.crouch))
	STATES.slide.jump.connect(func (): change_state(STATES.jump))
	# Hang Signals
	STATES.hang.drop.connect(func (): change_state(STATES.drop))
	STATES.hang.climbup.connect(func (): change_state(STATES.climbup))
	#STATES.hang.jump.connect(func (): change_state(STATES.jump))
	# Climbup Signals
	STATES.climbup.climbup_completed.connect(func (): change_state(STATES.crouch))
	# Wallrun Signals
	STATES.wallrun.drop.connect(func (): change_state(STATES.drop))
	STATES.wallrun.jump.connect(func (): change_state(STATES.jump))
	STATES.wallrun.hang.connect(func (): change_state(STATES.hang))

func change_state(new_state: State) -> void:

	if new_state is State:
		self.state.exit()
	
	new_state.enter()
	self.previous_state = self.state
	self.state = new_state
	state_label.text = state.name
