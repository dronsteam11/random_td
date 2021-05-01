extends GEntity

onready var player_data : PlayerData = get_node("/root/GameLevel/PlayerData")

#COMPONENTS
var _stats_c : EStatsComponent 
var _movement_c : EMovementComponent

#LOCAL
func _ready():
	_stats_c  = get_component(EStatsComponent)
	_movement_c = get_component(EMovementComponent)
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

func _path_move(delta):
	_movement_c.prev_position = self.global_position
	_movement_c.path_f.offset += delta * _stats_c.speed
	if _movement_c.path_f.unit_offset == 1:
		_finish()

#PUBLICK
func damage(dmg : float):
	_stats_c.health -= dmg
	if _stats_c.health <= 0:
		player_data.money += _stats_c.bounty
		_remove_self()

func set_path(path : PathFollow2D):
	_movement_c.path_f = path
