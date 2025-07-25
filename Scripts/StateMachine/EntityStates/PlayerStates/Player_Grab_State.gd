class_name PlayerGrabState
extends PlayerState

@export var _tag_data:TagData
@onready var _grab_area:Area2D = $"GrabArea"

var _grabbed_entity:EntityHandler = null
const GRAB_THRESHOLD = 12
const SEA_HEIGHT = -221

var _executed:bool

func _ready() -> void:
	_grabbed_entity = null
	_grab_area.collision_layer = 0
	_grab_area.collision_mask = 2
	_grab_area.area_entered.connect(on_area_entered)

func enter() -> void:
	super()
	_executed = false
	entity.animation_player.play(TRY_GRAB)
	entity.animation_player.animation_finished.connect(func(_anim): _executed = true)

func exit() -> void:
	var collision_shape:CollisionShape2D = _grab_area.get_node("CollisionShape2D")
	collision_shape.disabled = true

func process_frame(delta:float) -> State:
	if _executed:
		return idle_state
	else: if _grabbed_entity != null:
		_grabbed_entity.global_position = _grab_area.global_position
		var tween = TweensDataBase.get_tween("arc_go_to")
		tween.call({
			"object": _grabbed_entity,
			"pos": Vector2(_grab_area.global_position.x, SEA_HEIGHT),
			"duration": 1,
			"call_back": func():
				pass
				_grabbed_entity.disable()
		})
	return null

func on_area_entered(hurt_box:HurtBox) -> void:
	if hurt_box == null: return
	if (_tag_data.get_target_tags().has(hurt_box.get_tag()) 
	and hurt_box.get_health_handler()._current_health < GRAB_THRESHOLD):
		entity.animation_player.play(GRAB)
		_grabbed_entity = hurt_box.entity
		_grabbed_entity.state_machine.change_state_name_input("GrabbedState")
