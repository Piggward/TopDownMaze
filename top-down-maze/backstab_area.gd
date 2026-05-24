class_name BackstabArea
extends Area2D

@onready var plain_dagger = $PlainDagger
@onready var animation_player = $AnimationPlayer

const backstabable_states = ["patrol", "station", "return"]

var enemy: Enemy = null
var can_backstab = true

func _ready():
	enemy = get_parent()
	enemy.state_changed.connect(_on_state_changed)
	
func _on_state_changed(new_state):
	can_backstab = backstabable_states.has(new_state)
	plain_dagger.visible = can_backstab and get_overlapping_areas().size() > 0
	
func _on_area_entered(area):
	plain_dagger.visible = can_backstab


func _on_area_exited(area):
	plain_dagger.visible = false

func stab():
	plain_dagger.stop()
	animation_player.play("Kill")
	get_parent().kill()
