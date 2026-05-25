extends GPUParticles2D

@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D
@onready var ray_cast_2d = $RayCast2D
@onready var character_body_2d = $"../../CharacterBody2D"
@onready var point_light_2d = $PointLight2D
@onready var detection_area = $DetectionArea

var on_scrreen = false

func _on_visible_on_screen_notifier_2d_screen_entered():
	print("visible!")
	on_scrreen = true
	pass # Replace with function body.
	
func _process(delta):
	if not on_scrreen:
		return
	
	point_light_2d.visible = detection_area.target_in_sight
		
	#var angle = global_position.angle_to_point(character_body_2d.global_position)
	#ray_cast_2d.global_rotation = angle
	#point_light_2d.visible = check_collision(ray_cast_2d, character_body_2d)
	#print(point_light_2d.visible)

func check_collision(ray: RayCast2D, target: Node2D):
	if not ray.is_colliding():
		return false
	else:
		var obj = ray.get_collider()
		if obj == target:
			return true
	return false

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("not visible!")
	on_scrreen = false
	point_light_2d.visible = false
	pass # Replace with function body.
