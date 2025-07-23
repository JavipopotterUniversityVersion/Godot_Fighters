class_name PlayerHandler
extends EntityHandler

func _input(event: InputEvent) -> void:
	state_machine.process_input(event)
