class_name LifeBar
extends ProgressBar

var label:Label
@export var _health_handler:HealthHandler
@export var _dissapears:bool = true
const CORNFLOWER_BLUE:Color = Color(0.392157, 0.584314, 0.929412, 1)
const RED:Color = Color(1,0,0,1)

const TIME_VISIBLE:float = 1
var timer:float = 0

func _ready():
	await get_tree().create_timer(0.1).timeout
	if _dissapears: visible = false
	else: _health_handler = get_tree().get_first_node_in_group("Players").health_handler
	
	max_value = _health_handler.get_max_health()
	
	_health_handler.on_die.connect(func(): 
		value = 0
		_update_label())
	
	_health_handler.on_get_damage.connect(func(_dmg): 
		visible = true
		timer = 0
		value = _health_handler.get_health()
		_update_label()
		)

func _process(delta: float) -> void:
	if visible and _dissapears:
		timer += delta
		if timer >= TIME_VISIBLE:
			timer = 0
			visible = false

func _update_label():
	#label.text = str(_health_handler.get_health()) + "/" + str(_health_handler.get_max_health())
	pass
