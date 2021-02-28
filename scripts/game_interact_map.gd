extends TileMap

export var cell_magic : PackedScene
export var magic_tower : PackedScene

export var grid_path : NodePath
var grid : Node2D

onready var state_manager : StateManager = get_node("/root/GameLevel/StateManager")
onready var debug_node : Label = get_node("../../GUI/Control/DebugLabel")
onready var player_data : PlayerData = get_node("../../PlayerData")
var tiles

var cells : Dictionary
var target_cell = null
var prev_cell = null
onready var popup_menu = get_node("../../PopUp")

func _ready():
	grid = get_node(grid_path)
	
	tiles = get_used_cells_by_id(4)
	for tile in tiles:
		var cm = cell_magic.instance()
		cm.position = to_global(map_to_world(tile))
		cells[tile] = cm
		add_child(cm)
	pass

#func _unhandled_input(event):
#	if event is InputEventMouseMotion:
#		popup_menu.hide()
#		var new_cell = _get_cell()
#		if new_cell:
#			new_cell.self_modulate = Color.red
#			if target_cell and target_cell != new_cell:
#				target_cell.self_modulate = Color.white
#		elif target_cell:
#			target_cell.self_modulate = Color.white
#			target_cell = null
#		target_cell = new_cell
#	elif  event is InputEventScreenTouch and event.is_pressed() == false:
#		var new_cell : Node2D = _get_cell()
#		if !new_cell: return
#		if state_manager.build_state != 0:
#			state_manager.set_build_state(0)
#			print("!build!")
#			if new_cell.get_child_count() == 0 and player_data.money >= 30:
#				player_data.money -= 30
#				var mt = magic_tower.instance()
#				new_cell.add_child(mt)
#		elif new_cell.get_child_count() != 0:
#			print("!popup!")
#			_press_cell(new_cell)
#	pass

func _press_cell(cell : Node2D):
	print(prev_cell)
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
		state_manager.set_build_state(0)
		print("!build!")
		if new_cell.get_child_count() == 0 and player_data.money >= 30:
			player_data.money -= 30
			var mt = magic_tower.instance()
			new_cell.add_child(mt)
	elif new_cell.get_child_count() != 0:
		print("!popup!")
		_press_cell(new_cell)
	else:
		popup_menu.hide()
	prev_cell = new_cell

