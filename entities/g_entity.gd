extends Node
class_name GEntity

var active : bool = true

func get_component(c_type):
	for component in get_children():
		if component is c_type:
			return component
	printerr(str(c_type) +" not found")
