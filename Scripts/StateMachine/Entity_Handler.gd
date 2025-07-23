class_name EntityHandler
extends CharacterBody2D

@onready var state_machine:StateMachine = $"StateMachine"
@onready var animation_player:AnimationPlayer = $Animation

func _ready() -> void: 
	state_machine.init()

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func disable():
	visible = false
	set_process(false)
