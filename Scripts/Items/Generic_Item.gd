class_name Generic_Item
extends Node2D

@export var _item_name = "Sign"

func get_item(entity_handler:EntityHandler):
	entity_handler.change_animator("Animation_" + _item_name)
	entity_handler.global_position = global_position
	queue_free()
