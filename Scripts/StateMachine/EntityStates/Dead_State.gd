class_name DeadState
extends EntityState

var _dead:bool
signal on_dead
var push_back_value := 1.5

func enter() -> void:
	_dead = false
	entity.animation_player.play(DEAD)
	Camera.shake_camera(1.035, Vector2(15,15))
	HitStopManager.hit_stop_short()
	entity.animation_player.animation_finished.connect(func(_anim): _dead = true, 4)
	var tween = create_tween()
	tween.tween_property(self, "push_back_value", 0, 0.4)

func process_frame(delta:float) -> State:
	super(delta)
	if _dead: emit_signal("on_dead")
	return null
	
func process_physics(delta:float):
	pain_state.push_back(push_back_value)
	entity.move_and_slide()
	return null
