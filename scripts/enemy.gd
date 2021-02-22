extends PathFollow2D
class_name Enemy

export var health : float = 100.0
export var speed : float = 10.0

export var _sprite_bot_right : Texture
export var _sprite_bot_left : Texture
export var _sprite_top_left : Texture
export var _sprite_top_right : Texture

onready var _sprite = get_node("Sprite")

var _dir = 0
var _prev_pos : Vector2
func _ready():
	add_to_group("enemies")
	pass

func _process(delta):
	_prev_pos = self.global_position
	self.offset += delta * speed
	
	_dir = (self.global_position.angle_to_point(_prev_pos) / PI) * 180
	
	if _dir > 0 and _dir <= 45:
		_sprite.texture = _sprite_bot_right
	elif _dir <= 0 and _dir >= -45:
		_sprite.texture = _sprite_top_right
	elif _dir <= -135 and _dir >= -180:
		_sprite.texture = _sprite_top_left
	elif _dir >= 135 and _dir <= 180:
		_sprite.texture = _sprite_bot_left
	
	
func damage(dmg : float):
	health -= dmg
	if health <= 0:
		queue_free()
