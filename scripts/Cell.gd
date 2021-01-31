extends Area
class_name Cell

const _cell_agile_texture : Texture = preload("res://models/grid/CellAgileTower.png")
const _cell_magic_texture : Texture = preload("res://models/grid/CellMagicTower.png")
const _cell_strength_texture : Texture = preload("res://models/grid/CellStrengthTower.png")
const _cell_random_texture : Texture = preload("res://models/grid/CellRandomTower.png")

export (Enums.CellType) var cell_type  = Enums.CellType.Random

export var is_empty : bool = true

onready var _sprite = get_node("Sprite")

var _base_color = Color.white

func _ready():
	set_cell_type(cell_type) 
	pass

func set_cell_type(new_type) -> void:
	match new_type:
		Enums.CellType.Magic:
			_sprite.texture = _cell_magic_texture
		Enums.CellType.Strength:
			_sprite.texture = _cell_strength_texture
		Enums.CellType.Agile:
			_sprite.texture = _cell_random_texture
		_:
			_sprite.texture = _cell_random_texture

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventScreenTouch:
		print("asd")
		if event.pressed == true:
			_sprite.modulate = Color.green
		else:
			_sprite.modulate = Color.white
	elif event is InputEventScreenDrag:
		_sprite.modulate = _base_color
	pass # Replace with function body.
