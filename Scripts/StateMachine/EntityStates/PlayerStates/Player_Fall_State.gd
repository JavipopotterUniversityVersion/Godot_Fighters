class_name PlayerFallState
extends PlayerState
const AIR_SPEED:float = 400
@export var _hit_box:CollisionShape2D

func enter() -> void:
	super()
	entity.animation_player.play(FALL)

func exit() -> void:
	_hit_box.disabled = false

func process_physics(delta: float) -> State:
	move(get_move_dir().x)
	entity.move_and_slide()
	
	if subBody.position.y >= 0:
		subBody.position.y = 0
		if get_move_dir().x != 0: return walk_state
		else: return idle_state
			
	subBody.velocity.y += gravity * delta
	subBody.move_and_slide()
	return null

func move(move_dir:float) -> void:
	entity.velocity.x = move_dir * AIR_SPEED

func process_input(event:InputEvent) -> State:
	if event.is_action_pressed(punch_key): return jump_kick_state
	return null
