class_name PlayerStateMachine
extends EntityStateMachine

#States
@export_group("States")
@export var walk_state:PlayerState
@export var jump_state:PlayerState
@export var fall_state:PlayerState
@export var punch_state:PlayerState
@export var jump_kick_state:PlayerState
@export var grab_state:PlayerState

func process_input(event:InputEvent) -> void:
	var new_state:State = _current_state.process_input(event)
	if new_state: change_state(new_state)
