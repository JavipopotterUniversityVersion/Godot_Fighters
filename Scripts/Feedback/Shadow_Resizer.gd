extends Node2D
@export var target:Node2D
var _initial_scale
const JUMP_HEIGHT = -150

func _ready() -> void:
	_initial_scale = scale

func _process(delta: float) -> void:
	scale.x = lerp(_initial_scale.x, 0.0, (target.position.y-1)/JUMP_HEIGHT)
	scale.y = lerp(_initial_scale.y, 0.0, (target.position.y-1)/JUMP_HEIGHT)
