class_name Enemy
extends Area2D

@export var path_follow: PathFollow2D
@export var stationary := false
@export var patrol_speed:= 20.0
@export var chase_speed := 45.0
@onready var rich_text_label = $RichTextLabel
@onready var light_rotator = $LightRotator
@onready var detection_area = $LightRotator/DetectionArea
@onready var search_timer = $SearchTimer
@onready var shoot_timer = $ShootTimer
@onready var animated_sprite_2d = $AnimatedSprite2D

signal state_changed(new_state)

const FIREBALL = preload("uid://cllwve4cfu0wq")

var state = "patrol"
var path_dir = 1
var new_pos := Vector2.ZERO

#shooting
var cd_time := 1.0
var cd = false

#hunting
var last_hunting_pos := Vector2.ZERO

#searching
var keep_searching = false

#return
var return_target := Vector2.ZERO

#station
var og_pos:= Vector2.ZERO
var og_scale := 1

func _ready():
	if stationary:
		state = "station"
	og_pos = self.global_position
	new_pos = og_pos
	og_scale = self.scale.x

func _process(delta):
	if state == "station":
		if detection_area.target_in_sight:
			switch_state("hunt")
			return
		return
	elif state == "patrol":
		if detection_area.target_in_sight:
			switch_state("hunt")
			return
		path_follow.progress += patrol_speed * delta * path_dir
		if path_dir == 1 and path_follow.progress_ratio == 1.0:
			path_dir = -1
			self.scale.x = -1
		elif path_dir == -1 and path_follow.progress_ratio == 0.0:
			path_dir = 1
			self.scale.x = 1
		new_pos = path_follow.global_position
		pass
	elif state == "return":
		if detection_area.target_in_sight:
			switch_state("hunt")
			return
		if self.global_position == return_target:
			var next_state = "patrol" if not stationary else "station"
			switch_state(next_state)
			return
		new_pos = global_position.move_toward(return_target, delta * patrol_speed)
		self.scale.x = sign(return_target.x - self.global_position.x)
		pass
	elif state == "hunt":
		if not detection_area.target_in_sight or detection_area.target == null:
			switch_state("search")
			return
		new_pos = global_position.move_toward(detection_area.target.global_position, delta * chase_speed)
		last_hunting_pos = detection_area.target.global_position
		self.scale.x = sign(detection_area.target.global_position.x - self.global_position.x)
		pass
	elif state == "search":
		if detection_area.target_in_sight:
			switch_state("hunt")
			return
		if not keep_searching:
			switch_state("return")
			return
		if not self.global_position == last_hunting_pos:
			new_pos = global_position.move_toward(last_hunting_pos, delta * chase_speed)
			self.scale.x = sign(last_hunting_pos.x - self.global_position.x)
	if new_pos != global_position:
		light_rotator.look_at(new_pos)
		self.global_position = new_pos

func set_shoot_cd():
	cd = true
	shoot_timer.start(cd_time)
	await shoot_timer.timeout
	cd = false
	
func set_search_cd():
	keep_searching = true
	search_timer.start(2.5)
	await search_timer.timeout
	keep_searching = false
	
func kill():
	state = "death"
	animated_sprite_2d.play("death")
	await animated_sprite_2d.animation_finished
	self.queue_free()

func switch_state(new_state):
	print("switching to: ", new_state)
	match new_state:
		"patrol": rich_text_label.text = "patroling"; self.scale.x = path_dir
		"return": rich_text_label.text = "returning"; return_target = path_follow.global_position if not stationary else og_pos
		"hunt": rich_text_label.text = "found player";
		"search": rich_text_label.text = "searching"; set_search_cd()
		"station": rich_text_label.text = "station"; self.scale.x = og_scale; light_rotator.look_at(self.position + Vector2(og_scale, 0))
		
	state = new_state
	state_changed.emit(new_state)
