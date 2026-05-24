@tool
extends PointLight2D

func _process(delta):
	if texture.has_alpha():
		self.rotation += PI * delta
