class_name PlayerWalkingState
extends PlayerState

const SPEED:float = 400
var flipped:bool = false

func enter() -> void:
	super()
	entity.animation_player.play(WALK)

func process_frame(delta:float) -> State:
	
	if (get_move_dir().x > 0 and flipped) or (get_move_dir().x < 0 and not flipped):
		flipped = not flipped
		entity.scale.x = -3
			
	return null

func process_physics(delta: float) -> State:
	move(get_move_dir())
	entity.move_and_slide()
	if get_move_dir() == Vector2.ZERO: return idle_state
	return super(delta)

func process_input(event:InputEvent):
	if event.is_action_pressed(left_key): _last_pressed = left_key
	else: if event.is_action_pressed(right_key): _last_pressed = right_key
	else: _last_pressed = ""
	
	if event.is_action_pressed(jump_key): return jump_state
	if event.is_action_pressed(punch_key): return punch_state
	if event.is_action_pressed(grab_key): return grab_state

	return null

func move(move_dir:Vector2) -> void:
	entity.velocity.x = move_dir.x * SPEED
	entity.velocity.y = move_dir.y * SPEED
