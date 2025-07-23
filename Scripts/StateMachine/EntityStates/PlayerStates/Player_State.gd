class_name PlayerState
extends EntityState

var _last_pressed:String

#AnimationNames
const WALK:String = "Walk"
const PUNCH:String = "Punch"
const JUMP_KICK:String = "Jump_Kick"
const JUMP:String = "Jump"
const FALL:String = "Fall"

#States
@onready var walk_state:PlayerState = get_parent().walk_state
@onready var jump_state:PlayerState = get_parent().jump_state
@onready var fall_state:PlayerState = get_parent().fall_state
@onready var punch_state:PlayerState = get_parent().punch_state
@onready var jump_kick_state:PlayerState = get_parent().jump_kick_state

#Input Keys
var movement_key:String = "Movement"
var left_key:String = "Left"
var right_key:String = "Right"
var up_key:String = "Up"
var down_key:String = "Down"
var jump_key:String = "Jump"
var punch_key:String = "Punch"

func process_physics(delta: float) -> State:
	if (subBody.velocity.y > 0 and not subBody.position.y >= 0): 
		return fall_state
	subBody.velocity.y += gravity * delta
	subBody.move_and_slide()
	if subBody.position.y >= 0: subBody.position.y = 0
	return null

func get_move_dir() -> Vector2:
	var axis = Input.get_vector(left_key, right_key, up_key, down_key)
	if axis.x == 0:
		if _last_pressed == left_key: axis.x = -1
		else: if _last_pressed == right_key: axis.x = 1
	return axis
