class_name PlayerJumpKickState
extends PlayerState

var _has_attacked:bool
const AIR_SPEED:float = 400

func enter() -> void:
	_has_attacked = true
	entity.animation_player.play(JUMP_KICK)
	entity.animation_player.animation_finished.connect(func(_anim): 
		_has_attacked = false)

func process_frame(delta:float) -> State:
	if not _has_attacked:
		return fall_state
	return null

func exit():
	entity.animation_player.play("RESET")

func process_physics(delta:float) -> State:
	move(get_move_dir().x)
	entity.move_and_slide()

	if subBody.position.y >= 0:
		subBody.position.y = 0
		entity.animation_player.play("RESET")
	else:	
		subBody.velocity.y += gravity * delta
		subBody.move_and_slide()
		
	return null

func move(move_dir:float) -> void:
	entity.velocity.x = move_dir * AIR_SPEED
