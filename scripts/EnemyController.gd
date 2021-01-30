extends Node
class_name EnemyController

onready var myEnemy = preload("res://prefabs/enemies/Enemy.tscn")
export(Array, PackedScene) var enemies : Array = []
export var time_spawn : float = 1.0

var _list : Array  = [] setget , enemys_get
var _time_to_spawn = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	#print((enemies[0] as Enemy))
	pass # Replace with function body.

func enemys_get() -> Array :
	return _list
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_time_to_spawn += delta
	if _time_to_spawn >= time_spawn:
		create_enemy()
		_time_to_spawn = 0

	for e in _list:
		e.set_offset(e.get_offset() + 5 * delta)
	pass

func create_enemy() -> void:
	var new_enemy = myEnemy.instance()
	add_child(new_enemy)
	new_enemy.connect("destroy", self, "remove_enemy")
	_list.push_back(new_enemy)
	pass

func remove_enemy(enemy : Enemy) -> void:
	_list.erase(enemy)
	remove_child(enemy)
	enemy.disconnect("destroy", self, "remove_enemy")
	pass
