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
	# Run Signals
	STATES.run.jump.connect(func (): change_state(STATES.jump))
	STATES.run.stop.connect(func (): change_state(STATES.idle))
	STATES.run.drop.connect(func (): change_state(STATES.drop))
	# Jump Signals
	STATES.jump.drop.connect(func (): change_state(STATES.drop))
	# Drop Signals
	STATES.drop.landed.connect(func (): change_state(STATES.roll))
	# Roll Signals
	STATES.roll.roll_completed.connect(func (): change_state(STATES.idle))

func change_state(new_state: State) -> void:
	if new_state == previous_state:
		return

	if new_state is State:
		self.state.exit()
	
	new_state.enter()
	self.previous_state = self.state
	self.state = new_state
	state_label.text = state.name
