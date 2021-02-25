extends Node
class_name StateManager

var build_state : int = 0

func _ready():
	build_state = 0
	pass

func set_build_state(tower_level):
	build_state = tower_level
	pass
