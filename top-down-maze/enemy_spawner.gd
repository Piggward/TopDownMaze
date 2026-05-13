class_name EnemySpawner
extends Node2D

var enemy_amount = 1
const ENEMY = preload("uid://i2fv3coksw")
@onready var character_body_2d = $"../CharacterBody2D"

func _ready():
	spawn_enemy(1)
	increase_enemy_amount()
	
func increase_enemy_amount():
	enemy_amount += 1
	await get_tree().create_timer(randi_range(2, 5)).timeout
	increase_enemy_amount()
	
func spawn_enemy(amount):
	for i in amount:
		var e = ENEMY.instantiate()
		e.global_position = character_body_2d.global_position + Vector2(500, 0).rotated(randf())
		get_tree().root.add_child(e)
	
	await get_tree().create_timer(randi_range(2, 5)).timeout
	spawn_enemy(enemy_amount)
