class_name PlayerWalkingState
extends PlayerState

const SPEED:float = 400
var flipped:bool = false

var _last_pressed:String

func enter() -> void:
	super()
	entity.animation_player.play(WALK)

func process_frame(delta:float) -> State:
	
	if (get_move_dir() > 0 and flipped) or (get_move_dir() < 0 and not flipped):
		flipped = not flipped
		entity.scale.x = -3
			
	return null

func process_physics(delta: float) -> State:
	move(get_move_dir())
	if get_move_dir() == 0.0: return idle_state
	return super(delta)

func get_move_dir() -> float:
	var axis = Input.get_axis(left_key, right_key)
	if axis == 0:
		if _last_pressed == left_key: axis = -1
		else: if _last_pressed == right_key: axis = 1
	return axis

func process_input(event:InputEvent):
	
	if event.is_action_pressed(left_key): _last_pressed = left_key
	else: if event.is_action_pressed(right_key): _last_pressed = right_key
	else: _last_pressed = ""
	
	if event.is_action_pressed(jump_key): return jump_state
	if event.is_action_pressed(punch_key): return punch_state
	return null

func move(move_dir:float) -> void:
	entity.velocity.x = move_dir * SPEED
