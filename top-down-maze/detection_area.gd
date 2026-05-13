class_name DetectionArea
extends Area2D

@onready var ray_cast_1 = $RayCast1
@onready var ray_cast_2 = $RayCast2

var target: Node2D = null
var size: Vector2 = Vector2.ZERO
var target_in_sight:= false

func _process(delta):
	if target == null:
		return

	target_in_sight = check_collision(ray_cast_1, target) or check_collision(ray_cast_2, target)
		
func check_collision(ray: RayCast2D, target: Node2D):
	if not ray.is_colliding():
		return false
	else:
		var obj = ray.get_collider()
		if obj == target:
			return true
	return false

func _on_body_entered(body):
	if target == null:
		target = body
		ray_cast_1.activate(target, 5.0)
		ray_cast_2.activate(target, -5.0)
		#TODO: Decide size of body
	pass # Replace with function body.


func _on_body_exited(body):
	if body == target:
		target_in_sight = false
		target = null
		ray_cast_1.deactivate()
		ray_cast_2.deactivate()
	pass # Replace with function body.
