extends Node


var is_drag : bool = false
var is_press : bool = false

signal screen_drag(event)
signal screen_pressed(event)

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		is_drag = true
		emit_signal("screen_drag", event)
	elif event is InputEventScreenTouch and !event.is_pressed() and !is_drag:
		is_press = true
		emit_signal("screen_pressed", event)
	elif event is InputEventScreenTouch:	
		is_drag = false
		is_press = false
