class_name HurtBox
extends Area2D

@export var entity:EntityHandler
@export var _tag_data:TagData
@export var _health_handler:HealthHandler

var hitting_area:Node2D
var knock_back = 0

func get_tag() -> String:
	return _tag_data.get_tag()

func get_health_handler() -> HealthHandler:
	return _health_handler

func _ready() -> void:
	collision_layer = 2
	collision_mask = 0
