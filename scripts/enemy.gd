extends PathFollow2D
class_name Enemy

export var health : float = 100.0
export var speed : float = 10.0

export var dir_left : Rect2
export var dir_right : Rect2
export var dir_top : Rect2
export var dir_bottom : Rect2

var _dir = 0

func _ready():
	add_to_group("enemies")
	pass

func _process(delta):
	var _prev_pos = self.global_position
	self.offset += delta * speed
	var pos = self.global_position
	_dir = (pos.angle_to_point(_prev_pos) / PI) * 180
	#print(_dir)
	if _dir <= 45 and _dir >= -0:
		get_child(0).texture.region = dir_right
	elif _dir <= 120 and _dir >= -15:
		get_child(0).texture.region = dir_left
	elif _dir >= -120 and _dir <= -15:
		get_child(0).texture.region = dir_top
	elif _dir >= 45 and _dir <= 90:
		get_child(0).texture.region = dir_bottom

func damage(dmg : float):
	health -= dmg
	if health <= 0:
		queue_free()
