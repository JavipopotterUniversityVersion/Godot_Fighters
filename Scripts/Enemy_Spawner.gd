class_name EnemySpawner
extends Area2D

@export var _enemies:Array[PackedScene]
@export var _waves:int
@export var _enemies_per_wave:int
var _enemy_count:int = 0
signal next_wave

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(hurt_box:HurtBox) -> void:
	if hurt_box == null: return
	if (hurt_box.get_tag() != "Player"): return
	
	Camera.activate_front_wall()
	area_entered.disconnect(on_area_entered)
	spawn_waves()

func spawn_waves() -> void:
	for wave in range(_waves):
		for i in range(_enemies_per_wave):
			spawn_enemy_at_border()
		await next_wave
	Camera.deactivate_front_wall()

func spawn_enemy_at_border() -> void:
	if _enemies.is_empty(): return
	var enemy_scene:PackedScene = _enemies.pick_random()
	var enemy:EntityHandler = enemy_scene.instantiate()

	var spawn_position = get_random_border_position()
	enemy.global_position = spawn_position
	get_parent().add_child(enemy)
	
	enemy.on_disable.connect(_substract_enemy.call_deferred,4)
	_enemy_count += 1

func _substract_enemy():
	_enemy_count -= 1
	if _enemy_count <= 0:
		emit_signal("next_wave")

func get_random_border_position() -> Vector2:
	var shape := $CollisionShape2D.shape as RectangleShape2D
	var size = shape.extents * 2
	var top_left = global_position - shape.extents

	var side := randi() % 3
	var x: float
	var y: float

	match side:
		0: # bottom
			x = randf_range(0, size.x)
			y = size.y
		1: # left
			x = 0
			y = randf_range(0, size.y)
		2: # right
			x = size.x
			y = randf_range(0, size.y)

	return top_left + Vector2(x, y)
