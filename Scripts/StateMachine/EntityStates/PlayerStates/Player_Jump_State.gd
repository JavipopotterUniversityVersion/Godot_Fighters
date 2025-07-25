class_name PlayerJumpState
extends PlayerState

const JUMP_FORCE:float = -2000
const AIR_SPEED:float = 400

func enter() -> void:
	entity.velocity.y = JUMP_FORCE
	entity.animation_player.play(JUMP)

func process_physics(delta: float) -> State:
	move(get_move_dir())
	return super(delta)

func get_move_dir() -> float:
	return Input.get_axis(left_key, right_key)

func process_input(event:InputEvent) -> State:
	if event.is_action_pressed(punch_key): return jump_kick_state
	return null

func move(move_dir:float) -> void:
	entity.velocity.x = move_dir * AIR_SPEED
