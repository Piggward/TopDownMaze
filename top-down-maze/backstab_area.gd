extends Area2D
@onready var plain_dagger = $PlainDagger
@onready var animation_player = $AnimationPlayer

func _on_area_entered(area):
	plain_dagger.visible = true


func _on_area_exited(area):
	plain_dagger.visible = false

func stab():
	plain_dagger.stop
	animation_player.play("Kill")
	get_parent().kill()
