extends TileMapLayer
const TILESET = preload("uid://bc274vnswcddb")
const TILE_SET_RESOURCE = preload("uid://blre1mo8w7hjk")

# This script duplicates the tileset and replaces it with another one (without normal maps).
# This allows for not having to update a seperate scene without normal map.  
func _ready():
	tile_set = TILE_SET_RESOURCE.duplicate(true)

	# Get the atlas source (usually source ID 0)
	var source := tile_set.get_source(3) as TileSetAtlasSource

	# Load new texture
	var new_texture = TILESET

	# Replace atlas texture
	source.texture = new_texture
