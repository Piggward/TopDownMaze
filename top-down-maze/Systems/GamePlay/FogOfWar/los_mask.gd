extends SubViewport

@onready var point_light_2d = $"../PointLight2D"
@onready var camera_2d = $Camera2D
@onready var character_body_2d = $"../CharacterBody2D"
@onready var player_cam = $"../CharacterBody2D/Camera2D"
@onready var visibility_source = $VisibilitySource

func _process(delta):
	camera_2d.global_position = player_cam.global_position
	visibility_source.global_position = character_body_2d.global_position
