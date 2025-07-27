class_name HealthHandler
extends Node

signal on_get_damage
signal on_die

@export var _current_health:float = 10
@export var _max_health:float = 10

func get_damage(damage:float):
	_current_health -= damage
	_current_health = clampf(_current_health, 0, _max_health)
	
	if _current_health > 0: emit_signal("on_get_damage", damage)
	else: emit_signal("on_die")

func get_health() -> float:
	return _current_health

func get_max_health() -> float:
	return _max_health
