class_name PlayerGrabbingState
extends PlayerState

var _grabbed_entity:EntityHandler = null
var _entity_grab_pivot:Node2D
@onready var _grab_area:Node2D = $"GrabPoint"

const SEA_HEIGHT = -221
const SPEED:float = 300
var flipped:bool = false

func enter() -> void:
	super()
	_entity_grab_pivot = _grabbed_entity.get_node("GrabPivot")
	entity.animation_player.play(GRAB_WALK)
	entity.animation_player.speed_scale = 0

func exit() -> void:
	entity.animation_player.speed_scale = 1

func process_input(event:InputEvent) -> State:
	super(event)
	if event.is_action_pressed(grab_key): return throw_entity()
	
	if event.is_action_pressed(left_key): _last_pressed = left_key
	else: if event.is_action_pressed(right_key): _last_pressed = right_key
	else: _last_pressed = ""
	return null

func process_frame(delta:float) -> State:
	_grabbed_entity.global_position = _grab_area.global_position - _entity_grab_pivot.position * _grabbed_entity.scale.x
	
	if get_move_dir().x == 0: entity.animation_player.speed_scale = 0
	else: entity.animation_player.speed_scale = 1
	
	if (get_move_dir().x > 0 and flipped) or (get_move_dir().x < 0 and not flipped):
		flipped = not flipped
		entity.scale.x = -3
	return null

func throw_entity():
	_grabbed_entity.global_position = _grab_area.global_position
	var tween = TweensDataBase.get_tween("arc_go_to")
	tween.call({
		"object": _grabbed_entity,
		"pos": Vector2(_grab_area.global_position.x, SEA_HEIGHT),
		"duration": 1,
		"call_back": func():
			_grabbed_entity.disable()
			_grabbed_entity = null
	})
	return idle_state

func process_physics(delta: float) -> State:
	move(get_move_dir())
	entity.move_and_slide()
	return super(delta)

func move(move_dir:Vector2) -> void:
	entity.velocity.x = move_dir.x * SPEED
	entity.velocity.y = move_dir.y * SPEED
