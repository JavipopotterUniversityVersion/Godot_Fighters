class_name GrabbedState
extends EntityState

func enter() -> void:
	entity.animation_player.play("Grabbed")
