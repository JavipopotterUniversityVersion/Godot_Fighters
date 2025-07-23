class_name MoveTowardsPlayerState
extends EntityState

const SPEED:float = 100
var flipped:bool = false
@onready var player:Node2D = get_tree().get_nodes_in_group("Players")[0]

func enter() -> void:
	super()
	entity.animation_player.play("Walk")

func process_frame(delta:float) -> State:
	if (get_move_dir().x < 0 and flipped) or (get_move_dir().x > 0 and not flipped):
		flipped = not flipped
		entity.scale.x = -3
			
	return null

func process_physics(delta: float) -> State:
	move(get_move_dir())
	entity.move_and_slide()
	if get_move_dir().x == 0.0: return idle_state
	return super(delta)

func get_move_dir() -> Vector2:
	var move_dir:Vector2 = player.global_position - entity.global_position
	return move_dir.normalized()

func move(move_dir:Vector2) -> void:
	entity.velocity = move_dir * SPEED
