extends Node
class_name PlayerData

onready var _money_label = get_node("../GUI/Interface/Top/Left/CounterContainer/MoneyContainer/Label")
onready var _health_label = get_node("../GUI/Interface/Top/Left/CounterContainer/HealthContainer/Label")

export var money : int = 100 setget set_money, get_money
export var health : int = 100 setget set_health, get_health

func _ready():
	Engine.target_fps = 60;
	set_money(money)
	set_health(health)

func set_money(new_value : int) -> void:
	money = new_value
	_money_label.text = str(new_value)

func get_money() -> int:
	return money

func set_health(new_value: int) -> void:
	health = new_value
	_health_label.text = str(new_value)

func get_health() -> int:
	return health	
