extends TileMap

const _TOWER_COUNT_UPDATE = 2

export var cell_magic : PackedScene
export var magic_tower : PackedScene
export var magic_tower_2 : PackedScene

export var grid_path : NodePath
var grid : Node2D

onready var state_manager : StateManager = get_node("/root/GameLevel/StateManager")
onready var debug_node : Label = get_node("../../GUI/Control/DebugLabel")
onready var player_data : PlayerData = get_node("../../PlayerData")
var tiles

var cells : Dictionary
var towers : Dictionary

var target_cell = null
var prev_cell = null
onready var popup_menu = get_node("../../PopUp")

func _ready():
	grid = get_node(grid_path)
	popup_menu._tower_controller = self
	tiles = get_used_cells_by_id(4)
	for tile in tiles:
		var cm = cell_magic.instance()
		cm.position = to_global(map_to_world(tile))
		cells[tile] = cm
		add_child(cm)
	pass

func _press_cell(cell : Node2D):
	if cell != prev_cell or !popup_menu.visible:
		popup_menu.global_position = cell.global_position
		popup_menu.show()
	else:
		popup_menu.hide()
	
func _get_cell() -> Node2D:
	var pos = world_to_map(get_global_mouse_position())
	
	debug_node.text = "Tile: " + str(pos)
		
	if get_cellv(pos) != -1:
		return cells[pos]
	return null

func _on_screen_drag(event):
	pass # Replace with function body.

func _on_screen_pressed(event):
	var new_cell = _get_cell()
	if !new_cell:
		popup_menu.hide()
		prev_cell = null
		return
	
	if state_manager.build_state != 0:
		_build_tower(new_cell)
	elif new_cell.get_child_count() != 0:
		popup_menu._current_tower = new_cell.get_child(0)
		_press_cell(new_cell)
	else:
		popup_menu.hide()
	prev_cell = new_cell

func _build_tower(cell):
	state_manager.set_build_state(0)
	print("!build!")
	
	if cell.get_child_count() == 0 and player_data.money >= 1:
		player_data.money -= 1
		var mt : Tower = magic_tower.instance()
		cell.add_child(mt)
		
		add_tower(mt)
		#check_merge_towers()
	print(towers)

func check_merge_towers():
	for tower in towers.values():
		if(len(tower)) == 2:
			print("upgrade towers")
			var t0 : Tower = tower[0]
			tower[0].tower_lvl = 2
			var t1 = tower[1]
			tower.erase (t0)
			tower.erase (t1)
			t1.queue_free()
			var nt = magic_tower_2.instance()
			t0.get_parent().add_child(nt)
			t0.queue_free()
			add_tower(nt)
	pass

func merge_tower(tower: Tower):
	if tower == null: return
	if tower.tower_lvl < 2 and towers.has(tower.t_name) and len(towers[tower.t_name]) > _TOWER_COUNT_UPDATE - 1:
		var rem_t = _get_towers_arr(tower, _TOWER_COUNT_UPDATE - 1)
		var new_t = magic_tower_2.instance()
		rem_t[0].get_parent().call_deferred('add_child', new_t)
		_remove_towers(rem_t)
		call_deferred('add_tower',new_t)
	pass

func _remove_towers(tower_arr):
	var arr = towers[tower_arr[0].t_name]
	for t in tower_arr:
		arr.erase(t)
		t.call_deferred('queue_free')
		
func _get_towers_arr(tower : Tower, count):
	var t_arr = []
	for t in towers[tower.t_name]:
		if t != tower:
			t_arr.push_back(t)
		if len(t_arr) == count:
			break
	t_arr.push_front(tower)
	return t_arr

func add_tower(tower : Tower):
	if towers.has(tower.t_name):
		towers[tower.t_name].push_back(tower)
	else:
		towers[tower.t_name] = [tower]
		
