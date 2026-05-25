extends Area2D

func _process(delta):
	if Input.is_action_just_pressed("backstab"):
		var areas = get_overlapping_areas()
		if areas.size() == 0:
			return
		var area = areas[0]
		if area == null:
			return
		area.stab()
