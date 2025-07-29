class_name MoveTowardsPlayerState
extends EntityState

const SPEED:float = 100
@export var _tag_data:TagData
@onready var player:Node2D = get_tree().get_nodes_in_group("Players")[0]
@onready var _trigger_area:Area2D = $"TriggerArea"


func enter() -> void:
	super()
	entity.animation_player.play("Walk")
	_trigger_area.collision_layer = 0
	_trigger_area.collision_mask = 2
	_trigger_area.area_entered.connect(on_area_entered)

func exit() -> void:
	_trigger_area.area_entered.disconnect(on_area_entered)

func on_area_entered(hurt_box:HurtBox) -> void:
	if hurt_box and _tag_data.get_target_tags().has(hurt_box.get_tag()):
		entity.state_machine.change_state_name_input("AttackState")

func process_frame(delta:float) -> State:
	if player == null: return idle_state
	
	if (get_move_dir().x < 0 and entity.flipped) or (get_move_dir().x > 0 and not entity.flipped):
		entity.flipped = not entity.flipped
		entity.scale.x = -entity.scale.x
			
	return null

func process_physics(delta: float) -> State:
	if player == null: return idle_state
	
	move(get_move_dir())
	entity.move_and_slide()
	if get_move_dir().x == 0.0: return idle_state
	return super(delta)

func get_move_dir() -> Vector2:
	var move_dir:Vector2 = player.global_position - entity.global_position
	return move_dir.normalized()

func move(move_dir:Vector2) -> void:
	entity.velocity = move_dir * SPEED
