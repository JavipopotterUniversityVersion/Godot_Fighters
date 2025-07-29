class_name SceneReloader
extends Node

func reload_scene():
	get_tree().root.get_tree().reload_current_scene()
	Camera.get_tree().reload_current_scene()
