class_name PlayerFallState
extends PlayerState
const AIR_SPEED:float = 400

func enter() -> void:
	super()
	entity.animation_player.play(FALL)

func process_physics(delta: float) -> State:
	move(get_move_dir())
	
	if entity.is_on_floor():
		if get_move_dir() != 0: return walk_state
		else: return idle_state
			
	entity.velocity.y += gravity * delta
	entity.move_and_slide()
	return null

func get_move_dir() -> float:
	return Input.get_axis(left_key, right_key)

func move(move_dir:float) -> void:
	entity.velocity.x = move_dir * AIR_SPEED

func process_input(event:InputEvent) -> State:
	if event.is_action_pressed(punch_key): return jump_kick_state
	return null
