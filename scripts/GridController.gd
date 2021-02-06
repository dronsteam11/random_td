extends Node

var tower_list : Array = []

func _on_LevelObserver_add_tower(cell : Cell, tower):
	cell.set_tower(tower)
	tower_list.append(tower)
	print("agile ", _check_tower_count(Enums.CellType.Agile))
	pass

func _check_tower_count(type : int) -> int:
	var count = 0
	for t in tower_list:
		if t.type == type:
			count+=1
	return count
