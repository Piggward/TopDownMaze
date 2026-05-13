extends RigidBody2D

var hp = 100
var player 

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta):
	global_position = self.global_position.move_toward(player.global_position, delta * 10)

func take_damage():
	hp -= 50
	if hp <= 0:
		self.queue_free()
