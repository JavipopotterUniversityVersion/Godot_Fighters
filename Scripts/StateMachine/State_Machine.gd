class_name StateMachine
extends Node

@export var _inital_state:State
@export var _handler:EntityHandler
var _current_state:State

func init() -> void: change_state(_inital_state)

func process_frame(delta:float) -> void:
	var new_state:State = _current_state.process_frame(delta)
	if new_state: change_state(new_state)

func process_physics(delta:float) -> void:
	var new_state:State = _current_state.process_physics(delta)
	if new_state: change_state(new_state)

func change_state(new_state:State):
	if _current_state:
		_current_state.exit()
	_current_state = new_state
	new_state.enter()

func get_handler() -> EntityHandler:
	return _handler

func get_current_state() -> State:
	return _current_state
