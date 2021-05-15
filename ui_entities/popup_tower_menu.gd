extends Node2D

var _current_tower : Tower
var _tower_controller : Node

func _on_merge_tower_button_up():
	#print(_current_tower)
	_tower_controller.merge_tower(_current_tower)
	pass # Replace with function body.
