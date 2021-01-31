extends Camera

var _state = Enums.ControllState.None

onready var area : CollisionShape = get_node("/root/TestScene/CameraArea")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		self.translation -= Vector3(event.relative.x, 0, event.relative.y) * 0.1
		
		self.translation.x = clamp(self.translation.x,
			area.global_transform.origin.x - area.shape.extents.x / 2,
			area.global_transform.origin.x + area.shape.extents.x / 2 )
		
		self.translation.z = clamp(self.translation.z,
			area.global_transform.origin.z - area.shape.extents.z / 2,
			area.global_transform.origin.z + area.shape.extents.z / 2 )
		
	#elif event is InputEventScreenTouch:
	#	print(event.as_text())
		
func _on_BuildButton_pressed():
	_state = Enums.ControllState.Build
	pass # Replace with function body.
