extends Spatial



export (PackedScene) var bullet_prefab : PackedScene = preload("res://prefabs/Bullet.tscn")
export var shoot_cooldown : float = 1.0
export var shoot_damage : float = 10.0
var target : Enemy = null

onready var _enemy_controller : EnemyController = get_node("/root/TestScene/EnemyPath")
var _current_cooldown : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		target = find_target()
		
	_current_cooldown += delta
	if target != null and _current_cooldown >= shoot_cooldown:
		_current_cooldown = 0
		shoot()
	pass

func find_target() -> Enemy:
	if target != null:
		return target
	
	var count = len(_enemy_controller.enemys_get())
	if count == 0: return null
	var min_distance = self.global_transform.origin.distance_to(_enemy_controller.enemys_get()[0].global_transform.origin)
	var index = 0
	for i in range(1, count):
		var _current_dist = self.global_transform.origin.distance_to(
			_enemy_controller.enemys_get()[i].global_transform.origin)
	
		if min_distance > _current_dist:
			min_distance = _current_dist
			index = i
		
	return _enemy_controller.enemys_get()[index]
	
func shoot():
	var bullet = bullet_prefab.instance()
	bullet.set_target(target, shoot_damage)
	add_child(bullet)
	pass

func _on_enemy_area_entered(enemy : Enemy) -> void:
	if enemy == null:
		return
	if target != null:
		return
	target = enemy
	pass # Replace with function body.

func _on_enemy_area_exited(enemy : Enemy) -> void:
	if enemy == null:
		return
	if target == enemy:
		target = null
	pass # Replace with function body.
