extends Node
class_name LevelEventListener

const TOWER_PREBABS = {
	"level_1":[
		preload("res://prefabs/towers/MagicTower.tscn"),
		preload("res://prefabs/towers/AgileTower.tscn"),
		preload("res://prefabs/towers/StrengthTower.tscn")
	]
}

var current_controll_state = Enums.ControllState.None
var current_tower_list : Array = []

signal add_tower(cell, tower)

func select_cell(cell) -> void:
	match current_controll_state:
		Enums.ControllState.Build:
			current_controll_state = Enums.ControllState.None
			if !cell.is_empty:
				return
			
			var random_tower = TOWER_PREBABS["level_1"][rand_range(0, len(TOWER_PREBABS["level_1"]))].instance()
			emit_signal("add_tower", cell, random_tower)
	pass

func _on_BuildButton_pressed():
	if current_controll_state == Enums.ControllState.None:
		current_controll_state = Enums.ControllState.Build
	pass # Replace with function body.
