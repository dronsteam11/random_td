extends Node
class_name EnemyManager

const enemy_entity = preload("res://entities/enemies/tank.tscn")

export var active : bool = true
export var test_time_spawn : float = 10
var enemies : Array = []

func _ready():
	create_enemy()
	_test_spawn()
	pass

func _process(_delta):
	enemies = get_tree().get_nodes_in_group("enemies")

func create_enemy():
	var new_enemy = enemy_entity.instance()
	get_child(0).add_child(new_enemy)
	pass

func _test_spawn():
	while active:
		yield(get_tree().create_timer(test_time_spawn), "timeout")
		create_enemy()
