class_name StageStorage
extends Node

var STAGES = {
	"stage_0": "res://scenes/World.tscn",
	"stage_1": "res://scenes/World_02.tscn"
}

var current_stage: int = 0

func get_next_level() -> String:
	if STAGES.keys().size() > (current_stage + 1):
		current_stage += 1
		
	else: 
		current_stage = 0

	var value: String = str(current_stage)
	value = "stage_"+value
	return STAGES[value]
