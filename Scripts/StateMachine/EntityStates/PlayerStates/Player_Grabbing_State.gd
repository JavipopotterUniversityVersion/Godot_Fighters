class_name PlayerGrabbingState
extends PlayerState

var _grabbed_entity:EntityHandler = null
var _entity_grab_pivot:Node2D
@onready var _grab_area:Node2D = $"GrabPoint"

const SEA_HEIGHT = -221
const SPEED:float = 300
var _thrown:bool = false

func enter() -> void:
	super()
	_thrown = false
	_entity_grab_pivot = _grabbed_entity.get_node("GrabPivot")
	entity.animation_player.play(GRAB_WALK)
	entity.animation_player.speed_scale = 0
	

func exit() -> void:
	entity.animation_player.speed_scale = 1
	if not _thrown:
		_grabbed_entity.state_machine.reset()
		_grabbed_entity.flipped = entity.flipped
		_grabbed_entity = null

func process_input(event:InputEvent) -> State:
	super(event)
	if event.is_action_pressed(grab_key): return throw_entity()
	
	if event.is_action_pressed(left_key): _last_pressed = left_key
	else: if event.is_action_pressed(right_key): _last_pressed = right_key
	else: _last_pressed = ""
	return null

func process_frame(delta:float) -> State:
	if _grabbed_entity:
		if not entity.flipped: _grabbed_entity.global_position.x = _grab_area.global_position.x - _entity_grab_pivot.position.x * abs(_grabbed_entity.scale.x)
		else: _grabbed_entity.global_position.x = _grab_area.global_position.x + _entity_grab_pivot.position.x * abs(_grabbed_entity.scale.x)
		_grabbed_entity.global_position.y = _grab_area.global_position.y - _entity_grab_pivot.position.y * abs(_grabbed_entity.scale.x)
	
	if get_move_dir() == Vector2.ZERO: entity.animation_player.speed_scale = 0
	else: entity.animation_player.speed_scale = 1
	
	if (get_move_dir().x > 0 and entity.flipped) or (get_move_dir().x < 0 and not entity.flipped):
		entity.flipped = not entity.flipped
		entity.scale.x = -3
		_grabbed_entity.scale.x = -_grabbed_entity.scale.x 
	return null

func throw_entity():
	_thrown = true
	_grabbed_entity.global_position = _grab_area.global_position
	var tween = TweensDataBase.get_tween("arc_go_to")
	tween.call({
		"object": _grabbed_entity,
		"pos": Vector2(_grab_area.global_position.x, SEA_HEIGHT),
		"duration": 1,
		"final_size": 0.8,
		"call_back": func():
			_grabbed_entity.animation_player.play("Shark_Eaten")
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
