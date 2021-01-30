extends Spatial

class_name Bullet

export var speed : float = 10.0

var _damage : float = 0
var _target : Enemy = null

func set_target(target : Enemy, damage : float) -> void:
	_target = target
	_damage = damage
	pass

func _move_to_target(delta : float) -> void:
	if _target == null:
		_destroy()
		return

	var dir : Vector3 = _target.global_transform.origin - global_transform.origin
	var distanceThisFrame : float = speed * delta

	if dir.length() <= distanceThisFrame:
		_hit_target()
		return

	global_translate(dir.normalized() * distanceThisFrame)
	look_at(_target.global_transform.origin, Vector3.UP)

func _hit_target():
	if _target == null:
		_destroy()
		return
	_target.damage(_damage)
	_destroy()

func _physics_process(delta):
	_move_to_target(delta)

func _destroy() -> void:
	call_deferred("queue_free")
