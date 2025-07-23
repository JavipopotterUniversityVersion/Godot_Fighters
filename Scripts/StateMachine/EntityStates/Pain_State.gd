extends EntityState
var _damaged:bool
@onready var hurt_box:HurtBox = $"HurtBox"

func enter() -> void:
	_damaged = true
	entity.animation_player.play(PAIN, -1, 1.5)
	Camera.shake_camera(1.035, Vector2(15,15))
	entity.animation_player.animation_finished.connect(func(_anim): _damaged = false)

func process_frame(delta:float) -> State:
	if not _damaged: return idle_state
	return super(delta)

func process_physics(delta:float):
	push_back(1)
	return super(delta)

func exit():
	entity.velocity.x = 0

func push_back(multiplier:float):
	var push_dir:Vector2 = entity.global_position - hurt_box.hitting_area.global_position
	entity.velocity.x = push_dir.normalized().x * hurt_box.knock_back * multiplier
	entity.move_and_slide()
