extends Camera2D

onready var bounds_camera = get_node("../CameraBounds")
export var move_speed : float = 1.0
func _ready():
	pass

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		self.position -= event.relative * move_speed
		self.position.x = clamp(self.position.x,
			bounds_camera.global_position.x - bounds_camera.shape.extents.x / 2,
			bounds_camera.global_position.x + bounds_camera.shape.extents.x / 2 )
		
		self.position.y = clamp(self.position.y,
			bounds_camera.global_position.y - bounds_camera.shape.extents.y / 2,
			bounds_camera.global_position.y + bounds_camera.shape.extents.y / 2 )
		
