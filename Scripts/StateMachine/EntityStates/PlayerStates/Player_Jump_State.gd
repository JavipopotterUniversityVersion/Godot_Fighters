class_name PlayerJumpState
extends PlayerState

const JUMP_FORCE:float = -2000
const AIR_SPEED:float = 400

func enter() -> void:
	subBody.velocity.y = JUMP_FORCE
	entity.animation_player.play(JUMP)

func process_physics(delta: float) -> State:
	move(get_move_dir())
	entity.move_and_slide()

	return super(delta)

func process_input(event:InputEvent) -> State:
	if event.is_action_pressed(punch_key): return jump_kick_state
	return null

func move(move_dir:Vector2) -> void:
	entity.velocity = move_dir * AIR_SPEED
