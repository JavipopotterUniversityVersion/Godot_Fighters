class_name PlayerHandler
extends EntityHandler

@onready var interaction_area:Area2D = $InteractionArea
var _current_item:Generic_Item = null

func _ready() -> void:
	super()
	interaction_area.area_entered.connect(on_interaction_area_entered)
	interaction_area.area_exited.connect(on_interaction_area_exited)
	GameManager.time_out.connect(func(): health_handler.die())

func on_interaction_area_entered(item:Generic_Item) -> void:
	_current_item = item

func on_interaction_area_exited(item:Generic_Item) -> void:
	_current_item = null

func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func try_get_item():
	if _current_item: 
		_current_item.get_item(self)
		state_machine.change_state((state_machine as PlayerStateMachine).get_item_state)
		return true
	return false
