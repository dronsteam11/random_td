extends Camera

var _state = Enums.ControllState.None

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		self.translation -= Vector3(event.relative.x, 0, event.relative.y) * 0.1
	#elif event is InputEventScreenTouch:
	#	print(event.as_text())
		
func _on_BuildButton_pressed():
	_state = Enums.ControllState.Build
	pass # Replace with function body.
