extends Node
class_name StateManager

var build_state : int = 0
var popup_state : int = 0

signal on_state_change(prev_state, new_state)

func _ready():
	build_state = 0
	pass

func set_build_state(tower_level):
	emit_signal("on_state_change", build_state, tower_level)
	build_state = tower_level
	pass

func set_popup_state(new_state):
	popup_state = new_state
