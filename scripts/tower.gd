extends Node2D
class_name Tower

export var tower_lvl : int = 1
export var tower_type : int = 0

export var shoot_cooldown : float = 1.0
export var shoot_damage : float = 10.0
export var shoot_distance : float = 10.0
export var shoot_projectile_speed : float = 10.0

export var projectile_entities : PackedScene

var _is_ready_shoot = true
onready var _enemy_manager : EnemyManager = get_node("/root/GameLevel/EnemyManager")

var _enemy : GEntity = null

var t_name : String

func _ready():
	t_name = str(self.tower_lvl) + "_" +  str(self.tower_type)
	
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

	var new_target = _min_distance(_enemy_manager.enemies) #_enemy_manager.enemies[index]

	if self.global_position.distance_to(new_target.global_position) <= shoot_distance:
		_enemy = new_target

func _min_distance(enemies : Array) -> Enemy:
	var index = 0
	var min_distance = self.global_position.distance_to(
			enemies[index].global_position)

	for i in range(1, len(enemies)):
		var _current_dist = self.global_position.distance_to(
			enemies[i].global_position)

		if min_distance > _current_dist:
			min_distance = _current_dist
			index = i

	return enemies[index]

func _shoot():
	if _enemy == null: return
	var projectile : Projectile = projectile_entities.instance()
	projectile.set_target(_enemy, shoot_damage, shoot_projectile_speed)
	add_child(projectile)
	_start_cooldown()
	pass

func _start_cooldown():
	
	if is_inside_tree():
		_is_ready_shoot = false
		yield(get_tree().create_timer(shoot_cooldown), "timeout")
		_is_ready_shoot = true

func is_equals(other: Tower) -> bool:
	return other.tower_lvl == self.tower_lvl and other.tower_type == self.tower_type
