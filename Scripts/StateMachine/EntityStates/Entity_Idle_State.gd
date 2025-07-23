class_name EntityIdleState
extends EntityState

func enter() -> void:
	super()
	entity.velocity.x = 0
	entity.animation_player.play(IDLE)
