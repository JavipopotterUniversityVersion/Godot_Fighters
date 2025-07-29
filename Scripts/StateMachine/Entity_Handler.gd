class_name EntityHandler
extends CharacterBody2D

@export var state_machine:StateMachine
@onready var animation_player:AnimationPlayer = $Animation
@onready var health_handler:HealthHandler = $HealthHandler

signal on_disable

var _stop:bool
var flipped:bool

func change_animator(animator_name:String):
	animation_player.stop()
	animation_player = get_node(animator_name)

func _ready() -> void: 
	state_machine.init()

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func disable():
	emit_signal("on_disable")
	set_process(false)
	queue_free()
