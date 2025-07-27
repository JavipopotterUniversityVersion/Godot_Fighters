class_name PlayerPunchState
extends PlayerState

var _has_attacked:bool
var combo:Array = [PUNCH, KICK, FINAL_KICK]
var combo_index:int = 0
var next_state:PlayerState = idle_state

func enter() -> void:
	next_state = idle_state
	_has_attacked = true
	entity.velocity.x = 0
	
	entity.animation_player.animation_finished.connect(func(_anim): _has_attacked = false, 4)
	entity.animation_player.play(combo[combo_index], -1, 0.85)
	combo_index += 1
	
	if combo_index >= combo.size(): combo_index = 0

func process_frame(delta:float) -> State:
	super(delta)
	if not _has_attacked: 
		if next_state == idle_state: combo_index = 0
		return next_state
	return null

func process_input(event:InputEvent) -> State:
	super(event)
	if event.is_action_pressed(punch_key): next_state = self
	return null
