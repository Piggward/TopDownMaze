extends Node2D

func _ready():
	for child in get_children():
		child.emitting = true
	await get_tree().create_timer(5).timeout
	self.queue_free()
