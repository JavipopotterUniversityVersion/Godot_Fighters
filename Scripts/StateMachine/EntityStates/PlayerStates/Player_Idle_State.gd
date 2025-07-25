class_name PlayerIdleState
extends PlayerState

func enter() -> void:
	super()
	entity.velocity.x = 0
	entity.animation_player.play(IDLE)

func process_input(event:InputEvent) -> State:
	super(event)
	if event.is_action_pressed(movement_key): return walk_state
	if event.is_action_pressed(grab_key): return grab_state
	if event.is_action_pressed(jump_key): return jump_state
	if event.is_action_pressed(punch_key): return punch_state
	return null
