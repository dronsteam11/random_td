extends Node2D
class_name Tower

export var shoot_cooldown : float = 1.0
export var shoot_damage : float = 10.0
export var shoot_distance : float = 10.0
export var shoot_projectile_speed : float = 10.0

export var projectile_entities : PackedScene

var _is_ready_shoot = true
onready var _enemy_manager : EnemyManager = get_node("/root/GameLevel/EnemyManager")

var _enemy : Enemy = null

func _ready():
	pass
	
var az = 3.0

func _process(_delta):
	if _is_ready_shoot:
		_find_target()
		_shoot()
	pass

func _find_target():
	
	if _enemy != null:
		return
	var count = len(_enemy_manager.enemies)
	if count == 0: return
	
	var min_distance = self.global_position.distance_to(_enemy_manager.enemies[0].global_position)
	var index = 0
	for i in range(1, count):
		var _current_dist = self.global_transform.origin.distance_to(
			_enemy_manager.enemies[i].global_transform.origin)
	
		if min_distance > _current_dist:
			min_distance = _current_dist
			index = i
	var new_target = _enemy_manager.enemies[index]
	
	if self.global_position.distance_to(new_target.global_position) <= shoot_distance:
		_enemy = new_target
		

func _shoot():
	if _enemy == null: return
	var projectile : Projectile = projectile_entities.instance()
	projectile.set_target(_enemy, shoot_damage, shoot_projectile_speed)
	
	add_child(projectile)
	_start_cooldown()
	pass

func _start_cooldown():
	_is_ready_shoot = false
	yield(get_tree().create_timer(shoot_cooldown), "timeout")
	_is_ready_shoot = true
