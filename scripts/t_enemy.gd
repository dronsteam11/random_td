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
	call_deferred('_path_move', delta)
	call_deferred('_rotate')
	#_path_move(delta)
	#_rotate()

func _path_move(delta):
	_movement_c.prev_position = self.global_position
	_movement_c.path_f.offset += delta * _stats_c.speed
	if _movement_c.path_f.unit_offset == 1:
		_finish()

func _rotate():
	#_dir_c.direction = _movement_c.prev_position.angle_to_point(_movement_c.path_f.get_child(0).global_position / PI) * 180
	#(self.global_position.angle_to_point(_movement_c.path_f.get_child(0).global_position) / PI) * 180
	var dir  = self.global_position.direction_to(_movement_c.path_f.get_child(0).global_position)
	dir = dir.angle()

	if dir < -1.5 and dir >= -3:
		_dir_c.texture = _dir_c._sprite_top_left
	elif dir >= 1.5 and dir <= 3:
		_dir_c.texture = _dir_c._sprite_bot_left
	elif dir < 1.5 and dir >= 0:
		_dir_c.texture = _dir_c._sprite_bot_right
	elif dir <= 0 and dir >= -1.5:
		_dir_c.texture = _dir_c._sprite_top_right


#	if _dir_c.direction > 0 and _dir_c.direction <= 45:
#		_dir_c.texture = _dir_c._sprite_top_left
#	elif _dir_c.direction <= 0 and _dir_c.direction >= -45:
#		_dir_c.texture = _dir_c._sprite_bot_left
#	elif _dir_c.direction <= -135 and _dir_c.direction >= -180:
#		_dir_c.texture = _dir_c._sprite_bot_right
#	elif _dir_c.direction >= 135 and _dir_c.direction <= 180:
#		_dir_c.texture = _dir_c._sprite_top_right
	
#PUBLICK
func damage(dmg : float):
	_stats_c.health -= dmg
	if _stats_c.health <= 0:
		player_data.money += _stats_c.bounty
		call_deferred('_remove_self')

func set_path(path : PathFollow2D):
	_movement_c.path_f = path
