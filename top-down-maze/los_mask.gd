extends SubViewport

@onready var point_light_2d = $"../PointLight2D"
@onready var camera_2d = $Camera2D
@onready var character_body_2d = $"../CharacterBody2D"
@onready var player_cam = $"../CharacterBody2D/Camera2D"

func _process(delta):
	camera_2d.global_position = player_cam.global_position
	
#var text: Texture
#func _ready():
	#text = get_texture()
	#point_light_2d.material.set_shader_parameter(
		#"visibility_mask",
		#get_texture()
	#)
