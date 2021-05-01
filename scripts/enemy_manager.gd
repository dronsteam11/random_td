extends Node
class_name EnemyManager

const enemy_entity = preload("res://entities/enemies/tank.tscn")

export var spawn_node_path : NodePath
var spawn_node

export var active : bool = true
export var test_time_spawn : float = 10
var enemies : Array = []

func _ready():
	spawn_node = get_node(spawn_node_path)
	create_enemy()
	_test_spawn()
	pass

func _process(_delta):
	enemies = get_tree().get_nodes_in_group("enemies")

func create_enemy():
	var new_enemy = enemy_entity.instance()
	var path_f = PathFollow2D.new()
	path_f.rotation_degrees = 0
	path_f.rotate = false
	path_f.loop = false
	
	path_f.add_child(RemoteTransform2D.new())
	get_child(0).add_child(path_f)
	new_enemy.active = false
	
	spawn_node.add_child(new_enemy)
	new_enemy._ready()
	path_f.get_child(0).remote_path = new_enemy.get_path()
	new_enemy.set_path(path_f)
	new_enemy.active = true
	pass

func _test_spawn():
	while active:
		yield(get_tree().create_timer(test_time_spawn), "timeout")
		create_enemy()
