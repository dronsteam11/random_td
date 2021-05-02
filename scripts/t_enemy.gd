extends GEntity

onready var player_data : PlayerData = get_node("/root/GameLevel/PlayerData")

#COMPONENTS
var _stats_c : EStatsComponent 
var _movement_c : EMovementComponent
var _dir_c : EDirectionChange

#LOCAL
func _ready():
	_stats_c  = get_component(EStatsComponent)
	_movement_c = get_component(EMovementComponent)
	_dir_c = get_component(EDirectionChange)
	add_to_group("enemies")

func _finish():
	player_data.health -= 1
	_remove_self()
	
func _remove_self():
	active = false
	_movement_c.path_f.queue_free()
	queue_free()
	
func _process(delta):
	if !active: return
	_path_move(delta)
	_rotate()

func _path_move(delta):
	_movement_c.prev_position = self.global_position
	_movement_c.path_f.offset += delta * _stats_c.speed
	if _movement_c.path_f.unit_offset == 1:
		_finish()

func _rotate():
	_dir_c.direction = (self.global_position.angle_to_point(_movement_c.path_f.get_child(0).global_position) / PI) * 180

	if _dir_c.direction > 0 and _dir_c.direction <= 45:
		_dir_c.texture = _dir_c._sprite_top_left
	elif _dir_c.direction <= 0 and _dir_c.direction >= -45:
		_dir_c.texture = _dir_c._sprite_bot_left
	elif _dir_c.direction <= -135 and _dir_c.direction >= -180:
		_dir_c.texture = _dir_c._sprite_bot_right
	elif _dir_c.direction >= 135 and _dir_c.direction <= 180:
		_dir_c.texture = _dir_c._sprite_top_right
	
#PUBLICK
func damage(dmg : float):
	_stats_c.health -= dmg
	if _stats_c.health <= 0:
		player_data.money += _stats_c.bounty
		_remove_self()

func set_path(path : PathFollow2D):
	_movement_c.path_f = path
