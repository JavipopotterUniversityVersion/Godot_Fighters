class_name PlayerGrabState
extends PlayerState

@export var _tag_data:TagData
@onready var _grab_area:Area2D = $"GrabArea"

var _grabbed_entity:EntityHandler = null
const GRAB_THRESHOLD = 4

var _executed:bool

func _ready() -> void:
	_grabbed_entity = null
	_grab_area.collision_layer = 0
	_grab_area.collision_mask = 2
	_grab_area.area_entered.connect(on_area_entered)

func enter() -> void:
	super()
	_executed = false
	entity.animation_player.play(GRAB)
	entity.animation_player.animation_finished.connect(func(_anim): _executed = true, 4)

func exit() -> void:
	var collision_shape:CollisionShape2D = _grab_area.get_node("CollisionShape2D")
	collision_shape.disabled = true

func process_frame(delta:float) -> State:
	if _grabbed_entity != null: return grabbing_state
	if _executed: return idle_state
	return null

func on_area_entered(hurt_box:HurtBox) -> void:
	if hurt_box == null: return
	if (_tag_data.get_target_tags().has(hurt_box.get_tag()) 
	and hurt_box.get_health_handler()._current_health < GRAB_THRESHOLD
	and  _grabbed_entity == null):
		entity.animation_player.pause()
		_grabbed_entity = hurt_box.entity
		_grabbed_entity.state_machine.change_state_name_input("GrabbedState")
		grabbing_state._grabbed_entity = _grabbed_entity
