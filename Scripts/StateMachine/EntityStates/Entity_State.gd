class_name EntityState
extends State

@onready var entity:EntityHandler = _get_handler()
@onready var subBody:CharacterBody2D = entity.get_node("SubBody")
var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity", -9.8)

#States
@onready var idle_state:EntityState = get_parent().idle_state
@onready var pain_state:EntityState = get_parent().pain_state

#AnimationNames
const IDLE:String = "Idle"
const PAIN:String = "Pain"
const DEAD:String = "Dead"
