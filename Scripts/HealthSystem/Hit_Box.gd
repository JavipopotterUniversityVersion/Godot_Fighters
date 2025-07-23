class_name HitBox
extends Area2D

@export var _tag_data:TagData
@export var _damage = 1
@export var _knock_back = 300

func _ready() -> void:
	collision_layer = 0
	collision_mask = 2
	self.area_entered.connect(on_area_entered)

func on_area_entered(hurt_box:HurtBox) -> void:
	if hurt_box == null: return
	
	if _tag_data.get_target_tags().has(hurt_box.get_tag()):
		hurt_box.hitting_area = owner
		hurt_box.knock_back = _knock_back
		var other = hurt_box.get_health_handler()
		other.get_damage(_damage)
