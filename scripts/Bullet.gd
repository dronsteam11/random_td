extends Spatial

class_name Bullet

var _speed : float = 10.0
var _damage : float = 0
var _target : Enemy = null
var _last_pos : Vector3 = Vector3.ZERO

func set_target(target : Enemy, damage : float, speed : float) -> void:
	_target = target
	_damage = damage
	_speed = speed
	pass

func _move_to_target(delta : float) -> void:
	
	var dir : Vector3 = _last_pos - global_transform.origin
	var distanceThisFrame : float = _speed * delta

	if dir.length() <= distanceThisFrame:
		_hit_target()
		return
	
	global_translate(dir.normalized() * distanceThisFrame)
	look_at(_last_pos, Vector3.UP)

func _hit_target():
	if _target == null:
		_destroy()
		return
	_target.damage(_damage)
	_destroy()

func _physics_process(delta):
	if _target == null:
		_destroy()
		return
	
	if _target.is_inside_tree():
		_last_pos = _target.global_transform.origin
	_move_to_target(delta)

func _destroy() -> void:
	queue_free()
