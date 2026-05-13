extends RigidBody2D

func _ready():
	var camera = get_tree().get_first_node_in_group("camera")
	camera.set_trauma(0.5)
	await get_tree().create_timer(3).timeout
	self.queue_free()

func _physics_process(delta):
	self.rotation = self.linear_velocity.angle() - deg_to_rad(90)


func _on_body_entered(body):
	if body.name == "Enemy":
		body.take_damage()
	self.queue_free()
	pass # Replace with function body.
