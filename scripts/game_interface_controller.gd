extends Control


onready var state_manager : StateManager = get_node("/root/GameLevel/StateManager")

var timer : Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "on_second")
	add_child(timer)
	timer.start(1)
	state_manager.connect("on_state_change", self, "on_state_change")
	pass # Replace with function body.

func on_second():
	$Top/Debug/DebugLabel.text = "FPS: " +str(Performance.get_monitor(Performance.TIME_FPS))
	$Top/Debug/DebugLabel.text += "\nOBJ: " +str(Performance.get_monitor(Performance.OBJECT_COUNT ))

func on_state_change(prev_state, new_state):
	match new_state:
		1:
			$Bottom/ItemContainer/Tower3.self_modulate = Color.white
			$Bottom/ItemContainer/Tower5.self_modulate = Color.white
		3:
			$Bottom/ItemContainer/Tower1.self_modulate = Color.white
			$Bottom/ItemContainer/Tower5.self_modulate = Color.white
		5:
			$Bottom/ItemContainer/Tower1.self_modulate = Color.white
			$Bottom/ItemContainer/Tower3.self_modulate = Color.white
		_:
			$Bottom/ItemContainer/Tower1.self_modulate = Color.white
			$Bottom/ItemContainer/Tower3.self_modulate = Color.white
			$Bottom/ItemContainer/Tower5.self_modulate = Color.white
func _on_tower_pressed(tower_level):
	match tower_level:
		1:
			$Bottom/ItemContainer/Tower1.self_modulate = Color.darkblue
		3:
			$Bottom/ItemContainer/Tower3.self_modulate = Color.darkblue
		5:
			$Bottom/ItemContainer/Tower5.self_modulate = Color.darkblue
	state_manager.set_build_state(tower_level)
	pass # Replace with function body.
