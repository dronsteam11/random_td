extends Path


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tween
onready var follow = get_node("PathFollow")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(follow,
							"unit_offset",
							0, 1, 10,
							Tween.TRANS_LINEAR,
							Tween.EASE_IN_OUT)
	tween.set_repeat(true)
	#tween.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follow.set_offset(follow.get_offset() + 5 * delta)
	pass
