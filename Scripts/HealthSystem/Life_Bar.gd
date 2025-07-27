class_name LifeBar
extends ProgressBar

var label:Label
@export var _health_handler:HealthHandler
const CORNFLOWER_BLUE:Color = Color(0.392157, 0.584314, 0.929412, 1)
const RED:Color = Color(1,0,0,1)

func _ready():
	#label = get_node("Label")
	#position.y = get_parent().get_rect().size.y/2
	max_value = _health_handler.get_max_health()
	
	_health_handler.on_die.connect(func(dmg): 
		value = _health_handler.get_health()
		_update_label())
	
	_health_handler.on_get_damage.connect(func(dmg): 
		value = _health_handler.get_health()
		_update_label())

func _update_label():
	#label.text = str(_health_handler.get_health()) + "/" + str(_health_handler.get_max_health())
	pass
