class_name ObjectDetector
extends Area2D

var area_raycasts := {}


func _process(delta):
	for area in area_raycasts:
		var ray = area_raycasts[area]
		ray.rotation = self.global_position.angle_to_point(area.global_position)

func _on_area_entered(area):
	var ray = RayCast2D.new()
	ray.target_position = Vector2(100, 0)
	add_child(ray)
	area_raycasts[area] = ray

func _on_area_exited(area):
	area_raycasts.erase(area)
