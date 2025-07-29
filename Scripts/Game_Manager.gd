extends Node

const TOTAL_TIME:float = 5
var time_left:float = TOTAL_TIME

signal on_change_time_left
signal time_out
var out:bool = false

func reset():
	get_tree().root.get_tree().reload_current_scene()
	Camera.get_tree().reload_current_scene()

func _process(delta: float) -> void:
	if out: return
	
	time_left -= delta
	emit_signal("on_change_time_left", roundi(time_left))
	time_left = clamp(time_left, 0, TOTAL_TIME)
	if time_left <= 0: 
		time_out.emit()
		out = true
