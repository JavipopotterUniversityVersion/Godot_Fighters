class_name EntityHandler
extends CharacterBody2D

@export var state_machine:StateMachine
@onready var animation_player:AnimationPlayer = $Animation

func _ready() -> void: 
	state_machine.init()

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func disable():
	print("callback")
	queue_free()
