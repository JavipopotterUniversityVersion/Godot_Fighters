class_name PlayerState
extends EntityState

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
var jump_key:String = "Jump"
var punch_key:String = "Punch"

func process_physics(delta: float) -> State:
	if (entity.velocity.y > 0 and not entity.is_on_floor()): 
		return fall_state
		
	entity.velocity.y += gravity * delta
	entity.move_and_slide()
	return null
