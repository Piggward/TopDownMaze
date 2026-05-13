extends Sprite2D

var og_scale:= Vector2.DOWN
var tween: Tween

func _ready():
	og_scale = scale
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	start_tween(true)
	
func start_tween(up: bool):
	if up:
		tween.tween_property(self, "scale", og_scale * 2, 0.2)
	else:
		tween.tween_property(self, "scale", og_scale, 0.45)
		
	await tween.finished
	start_tween(!up)
	
func stop():
	tween.stop()
	scale = og_scale
