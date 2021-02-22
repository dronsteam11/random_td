extends TileMap

export var cell_magic : PackedScene
export var magic_tower : PackedScene

onready var debug_node : Label = get_node("../../GUI/Control/DebugLabel")
onready var player_data : PlayerData = get_node("../../PlayerData")
var tiles

var cells : Dictionary

var target_cell = null

func _ready():
	tiles = get_used_cells_by_id(4)
	for tile in tiles:
		var cm = cell_magic.instance()
		#var mt = magic_tower.instance()
		
		cm.position = to_global(map_to_world(tile))
		
		cells[tile] = cm
		var grid = get_node("../Grid")
		grid.add_child(cm)
		#cm.add_child(mt)
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var new_cell = _get_cell()
		if new_cell:
			new_cell.modulate = Color.red
			if target_cell and target_cell != new_cell:
				target_cell.modulate = Color.white
		elif target_cell:
			target_cell.modulate = Color.white
			target_cell = null
		target_cell = new_cell
	elif event is InputEventScreenTouch:
		var new_cell : Node2D = _get_cell()
		if !new_cell: return
		
		if new_cell.get_child_count() == 0 and player_data.money >= 30:
			player_data.money -= 30
			var mt = magic_tower.instance()
			new_cell.add_child(mt)
	pass

func _get_cell() -> Node2D:
	var pos = world_to_map(get_global_mouse_position())
	debug_node.text = "Tile: " + str(pos)
		
	if get_cellv(pos) != -1:
		return cells[pos]
	return null
