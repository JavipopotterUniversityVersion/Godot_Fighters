class_name PlayerPunchState
extends PlayerState

var _has_attacked:bool

func enter() -> void:
	_has_attacked = true
	entity.velocity.x = 0
	entity.animation_player.play(PUNCH)
	entity.animation_player.animation_finished.connect(func(_anim): _has_attacked = false)

func process_frame(delta:float) -> State:
	super(delta)
	if not _has_attacked: return idle_state
	return null
