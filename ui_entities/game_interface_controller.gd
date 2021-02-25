extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "teonr
onready var state_manager : StateManager = get_node("/root/GameLevel/StateManager")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_tower_pressed(tower_level):
	state_manager.set_build_state(tower_level)
	pass # Replace with function body.
