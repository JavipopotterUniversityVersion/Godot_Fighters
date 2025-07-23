class_name PlayerJumpKickState
extends PlayerState

var _has_attacked:bool

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
	entity.velocity.y += gravity * delta
	entity.move_and_slide()
	if(entity.is_on_floor()): 
		entity.animation_player.play("RESET")
	return null
