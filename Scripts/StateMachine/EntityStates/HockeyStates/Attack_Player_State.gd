class_name AttackPlayerState
extends EntityState

var _has_attacked:bool
var combo:Array = ["Punch"]
var combo_index:int = 0
var next_state:EntityState = idle_state

func enter() -> void:
	next_state = idle_state
	_has_attacked = true
	entity.velocity.x = 0
	
	entity.animation_player.animation_finished.connect(func(_anim): _has_attacked = false, 4)
	entity.animation_player.play(combo[combo_index], -1, 1)
	combo_index += 1
	
	if combo_index >= combo.size(): combo_index = 0

func exit() -> void:
	entity.animation_player.play(&"RESET")
	#entity.animation_player.advance(0)

func process_frame(delta:float) -> State:
	super(delta)
	if not _has_attacked: 
		if next_state == idle_state: combo_index = 0
		return next_state
	return null
