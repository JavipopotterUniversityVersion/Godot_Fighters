extends Label
@export var color_gradient:Gradient

func _ready() -> void:
	GameManager.on_change_time_left.connect(update_text)

func update_text(time_left:int):
	text = str(time_left)
	label_settings.font_color = color_gradient.sample(time_left/GameManager.TOTAL_TIME)
