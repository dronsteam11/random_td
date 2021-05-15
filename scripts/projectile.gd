extends Node2D
class_name Projectile

var damage : float
var speed : float

var target : GEntity setget set_target
var _target : GEntity

func set_target(trg : GEntity, dmg : float = 10.0, spd : float = 5.0):
	_target = trg
	self.speed = spd
	self.damage = dmg

func _process(delta):
	if _target != null and _target.is_inside_tree():
		var target_pos = _target.global_position

		var dir : Vector2 = target_pos - self.global_position
		
		var distanceThisFrame : float = speed * delta
		
		if dir.length() <= distanceThisFrame:
			_target.call_deferred('damage', damage)
			#_target.damage(damage)
			call_deferred('queue_free')
			return

		global_translate(dir.normalized() * distanceThisFrame)
		look_at(_target.global_position)
	else:
		queue_free()
	
