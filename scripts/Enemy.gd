class_name Enemy
extends Spatial 

signal spawn
signal destroy(enemy)

export var health : float = 100
export var speed : float = 5

func _ready():
	emit_signal("spawn")
	pass

func damage(dmg: float):
	health -= dmg
	if health <= 0:
		emit_signal("destroy", self)
		queue_free()
	pass
