extends Label

func _ready() -> void:
	GlobalSignals.on_enemies_appeared.connect(disable)
	GlobalSignals.on_enemies_defeated.connect(enable)

func enable():
	visible = true

func disable():
	visible = false
