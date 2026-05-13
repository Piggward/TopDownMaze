extends RayCast2D



func _process(delta):
	if is_colliding():
		var object = get_collider()
		
