class_name EntityStateMachine
extends StateMachine

@export_group("States")
@export var idle_state:EntityState
@export var pain_state:EntityState
@export var dead_state:EntityState

func get_damage(damage:float):
	change_state(pain_state)

func die():
	change_state(dead_state)
