class_name PlayerGetItemState
extends PlayerState

func enter() -> void:
	entity.velocity.x = 0
	entity.animation_player.play(&"ENTER")
	entity.animation_player.animation_finished.connect(func(_anim): entity.state_machine.change_state(idle_state), 4)
