extends Node2D

@onready var test_area = $TestArea
@onready var collision_shape_2d: CollisionShape2D = $TestArea/CollisionShape2D
@onready var point_light_2d = $PointLight2D
@onready var detection_area: DetectionArea = $PointLight2D/DetectionArea
@onready var rich_text_label = $RichTextLabel

func _process(delta):
	point_light_2d.rotation += delta / 2
	
	if detection_area.target_in_sight:
		rich_text_label.text = "[color=green] Colliding with area! [/color]"
	else:
		rich_text_label.text = "[color=red] not colliding [/color]"
	#if not detection_area.has_overlapping_areas():
		#return
	#var angle = ray_cast_2d.global_position.angle_to_point(test_area.global_position)
	#var angle_offset = ray_cast_2d.global_position.angle_to_point(test_area.global_position - Vector2(size / 2, 0).rotated(angle - 90))
	#var angle_offset2 = ray_cast_2d.global_position.angle_to_point(test_area.global_position - Vector2(-size / 2, 0).rotated(angle - 90))
	#ray_cast_2d.global_rotation = angle_offset
	#ray_cast_2d_2.global_rotation = angle_offset2
	#if not ray_cast_2d.is_colliding():
		#rich_text_label.text = "[color=red] not colliding [/color]"
	#else:
		#var obj = ray_cast_2d.get_collider()
		#if obj.name == "TestArea":
			#rich_text_label.text = "[color=green] Colliding with area! [/color]"
		#elif obj.name == "Area2D":
			#rich_text_label.text = "[color=orange] Colliding with occluder! [/color]"
			#
		#
#func check_collision(ray: RayCast2D, target: Node2D, label: RichTextLabel):
	#if not ray.is_colliding():
		#label.text = "[color=red] not colliding [/color]"
	#else:
		#var obj = ray.get_collider()
		#if obj == target:
			#label.text = "[color=green] Colliding with target! [/color]"
		#else:
			#label.text = "[color=orange] Colliding with obstacle! [/color]"
