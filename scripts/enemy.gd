extends PathFollow2D
class_name Enemy

onready var _stats_c : EStatsComponent = get_component(EStatsComponent)

export var _sprite_bot_right : Texture
export var _sprite_bot_left : Texture
export var _sprite_top_left : Texture
export var _sprite_top_right : Texture

onready var _sprite : Sprite = get_node("Sprite")
onready var player_data : PlayerData = get_node("/root/GameLevel/PlayerData")

var _dir :float = 0
var _prev_pos : Vector2
func _ready():
	add_to_group("enemies")

func _process(delta):
	
	_prev_pos = self.global_position
	self.offset += delta * _stats_c.speed
	
	_dir = (self.global_position.angle_to_point(_prev_pos) / PI) * 180
	
	if _dir > 0 and _dir <= 45:
		_sprite.texture = _sprite_bot_right
	elif _dir <= 0 and _dir >= -45:
		_sprite.texture = _sprite_top_right
	elif _dir <= -135 and _dir >= -180:
		_sprite.texture = _sprite_top_left
	elif _dir >= 135 and _dir <= 180:
		_sprite.texture = _sprite_bot_left
	
	if unit_offset == 1:
		finish()
	
func finish():
	player_data.health -= 1
	queue_free()
	pass
	
func damage(dmg : float):
	_stats_c.health -= dmg
	if _stats_c.health <= 0:
		player_data.money += _stats_c.bounty
		queue_free()

func get_component(component_type):
	for component in get_children():
		if component is component_type:
			return component
	printerr(str(component_type) +" not found")
	return null
