extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rt = 3
func _ready():
	rt = self.rect_size.x/self.rect_size.y
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rect_size.x = get_viewport_rect().size.x
	self.rect_size.y = self.rect_size.x / rt
	self.rect_global_position = Vector2(0, get_viewport_rect().size.y - self.rect_size.y)
	pass
