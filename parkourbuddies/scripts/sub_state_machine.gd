class_name SubStateMachine
extends State

@export var object: Player
@export var sub_state: State
var previous_sub_state: State

# Functions
func _ready() -> void:
	set_physics_process(false)

func enter() -> void:
	set_physics_process(true)

func exit() -> void:
	set_physics_process(false)

func change_state(new_sub_state: State) -> void:
	if new_sub_state == previous_sub_state:
		return

	if new_sub_state is State:
		self.state.exit()
	
	new_sub_state.enter()
	self.previous_sub_state = self.sub_state
	self.sub_state = new_sub_state
