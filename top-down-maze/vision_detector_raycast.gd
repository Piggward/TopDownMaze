class_name VisionRayCast
extends RayCast2D

var size_offset: float = 0.0
var target: Node2D
var active := false

func _process(delta):
	if not active:
		return
		
	var angle = global_position.angle_to_point(target.global_position)
	var angle_offset = global_position.angle_to_point(target.global_position - Vector2(size_offset / 2, 0).rotated(angle - 90))
	global_rotation = angle_offset
	#self.rotation = clamp(rotation, deg_to_rad(-45), deg_to_rad(45))

func activate(new_target: Node2D, size: float):
	target = new_target
	size_offset = size
	active = true
	
func deactivate():
	active = false
