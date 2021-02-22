extends Sprite

var _position : Vector2
var _tween : Tween

var _rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	
	_position = position
	_tween = Tween.new()
	add_child(_tween)
	_tween.connect("tween_all_completed", self, "on_tween_completed")
	on_tween_completed()
	

func on_tween_completed():
	_rng.randomize()
	var _duration = _rng.randf_range(0.5, 2)
	_tween.interpolate_property(self,
		"position",
		position,
		_position + Vector2(_rng.randf_range(-10,10),
				_rng.randf_range(-10,10)),
		_duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)
		
	_tween.interpolate_property(self, "rotation_degrees",
		rotation_degrees,
		_rng.randf_range(-5,5),
		_duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)
	_tween.start()
	
