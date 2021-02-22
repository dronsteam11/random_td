extends TileMap

export var cell_magic : PackedScene
export var magic_tower : PackedScene

onready var debug_node : Label = get_node("../../Control/Label")
var tiles

var cells : Dictionary

var target_cell = null
func _ready():
	tiles = get_used_cells_by_id(4)
	for tile in tiles:
		var cm = cell_magic.instance()
		var mt = magic_tower.instance()
		cm.position = to_global(map_to_world(tile))
		#cm.position.y += 81
		cells[tile] = cm
		var grid = get_node("../Grid")
		grid.add_child(cm)
		cm.add_child(mt)
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var pos = world_to_map(get_global_mouse_position())
		#debug_node.text = str(pos)
		if get_cellv(pos) != -1:
			cells[pos].modulate = Color.red
			if target_cell and target_cell != cells[pos]:
				target_cell.modulate = Color.white
			target_cell = cells[pos]
		else:
			if target_cell:
				target_cell.modulate = Color.white
				target_cell = null
	
	pass
