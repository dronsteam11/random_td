extends Node2D
class_name Projectile

var damage : float
var speed : float

var target : Enemy setget set_target
var _target : Enemy

func set_target(trg : Enemy, dmg : float = 10.0, spd : float = 5.0):
	_target = trg
	self.speed = spd
	self.damage = dmg

func _process(delta):
	if _target != null and _target.is_inside_tree():
		var target_pos = _target.global_position

		var dir : Vector2 = target_pos - self.global_position
		
		var distanceThisFrame : float = speed * delta
		
		if dir.length() <= distanceThisFrame:
			_target.damage(damage)
			queue_free()
			return

		global_translate(dir.normalized() * distanceThisFrame)
		look_at(_target.global_position)
	else:
		queue_free()
	
