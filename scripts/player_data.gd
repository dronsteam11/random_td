extends Node
class_name PlayerData

onready var _money_label = get_node("../GUI/Interface/Top/Left/CounterContainer/MoneyContainer/Label")

export var money : int = 100 setget set_money, get_money

func _ready():
	set_money(money)
func set_money(new_value : int) -> void:
	money = new_value
	_money_label.text = str(new_value)

func get_money() -> int:
	return money
