extends TileMapLayer

@export var use_normal_map: bool = true
const TILESET = preload("uid://bc274vnswcddb")

func _ready():
	if use_normal_map:
		return
