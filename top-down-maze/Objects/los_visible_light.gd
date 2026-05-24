extends Sprite2D

func _ready():
	var node = get_tree().get_first_node_in_group("Los_layer")
	self.material.set_shader_parameter(
		"visibility_mask",
		node.get_texture()
	)
