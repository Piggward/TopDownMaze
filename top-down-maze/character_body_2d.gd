class_name Player
extends CharacterBody2D


const SMOKE_PUFF = preload("uid://q8cc2ody26k8")
const FIREBALL = preload("uid://cllwve4cfu0wq")

@export var speed := 50.0
@export var accelleration := 350

@onready var camera_2d = $Camera2D
@onready var ghost = $Ghost
@onready var ghost_reminder = $GhostReminder
@onready var ghost_timer = $GhostTimer

var state = "running"
var cd = false
var cd_time = 0.45

#ghost
var MAX_TETHER = 40
var tp_cd = false

func _physics_process(delta):
	var input = Input.get_axis("left", "right")
	var input2 = Input.get_axis("up", "down")
	var direction = Vector2(input, input2).normalized()
	
	if state == "running":
		velocity = velocity.move_toward(direction * speed, delta * accelleration)
	elif state == "ghost":
		if direction != Vector2.ZERO:
			ghost.position = ghost.position.move_toward(direction * MAX_TETHER, delta * 100)
		
	if state != "ghost" and Input.is_action_just_pressed("teleport") and not tp_cd:
		state = "ghost"
		ghost.visible = true
		ghost.position = Vector2.ZERO
		velocity = Vector2.ZERO
	elif state == "ghost" and Input.is_action_just_released("teleport"):
		state = "running"
		ghost.visible = false
		if ghost.position.length() > 5:
			set_tp_cd()
			var smoke = SMOKE_PUFF.instantiate()
			get_tree().root.add_child(smoke)
			smoke.global_position = self.global_position
			self.position += ghost.position
	
	move_and_slide()

func set_tp_cd():
	tp_cd = true
	ghost_reminder.visible = false
	ghost_timer.start()
	await ghost_timer.timeout
	ghost_reminder.visible = true
	tp_cd = false
	
	#if Input.is_action_just_pressed("left_click") and not cd:
		#cd = true
		#var f: RigidBody2D = FIREBALL.instantiate()
		#var angle = self.global_position.angle_to_point(get_global_mouse_position())
		#f.linear_velocity = Vector2(175, 0).rotated(angle)
		#get_tree().root.add_child(f)
		#f.global_position = self.global_position + Vector2(15, 0).rotated(angle)
		#await get_tree().create_timer(cd_time).timeout
		#cd = false


func _on_backstab_detector_area_entered(area):
	pass # Replace with function body.
