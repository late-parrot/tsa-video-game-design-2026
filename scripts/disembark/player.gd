class_name DisembarkPlayer extends CharacterBody2D

var laser_scene = preload("res://scenes/disembark/laser.tscn")

@onready var disembark = $".."
@onready var main = $"../.."

#@export var SPEED = 100.0
#@export var ACCELERATION = 1000.0
#@export var FRICTION = 300.0
#@export var ROTATION_SPEED = 6.0
#
#func _physics_process(delta: float) -> void:
	#var direction := Input.get_vector("left", "right", "up", "down")
	#if direction:
		#rotation = rotate_toward(rotation, direction.angle(), ROTATION_SPEED*delta)
		#if is_equal_approx(rotation, -PI):
			#rotation = PI
	#if direction and rotation == direction.angle():
		#velocity = velocity.move_toward(direction*SPEED, ACCELERATION*delta)
	#else:
		#velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	#move_and_slide()

#####################
##  GRID MOVEMENT  ##
#####################

const TILE_SIZE = 16
const ROTATION_SPEED = 8.0
const MOVE_TIME = 0.2
var moving = true
var direction = 0
var shoot_allowed = true

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	moving = false

func _physics_process(delta: float) -> void:
	%Sprite.rotation = move_toward(%Sprite.rotation, direction, ROTATION_SPEED*delta/Game.move_speed)
	if not moving and (disembark is Spaceport or disembark.energy >= 0):
		var d := Input.get_vector("left", "right", "up", "down")
		# Set the vector to whichever direction is strongest
		d = Vector2(sign(d.x), 0) if abs(d.x) > abs(d.y) \
			else Vector2(0, sign(d.y))
		if d:
			direction = d.angle()
			var collision = move_and_collide(d*TILE_SIZE, true)
			if collision:
				return
			moving = true
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(self, "position", position+d*TILE_SIZE, MOVE_TIME/Game.move_speed)
			tween.tween_callback(move_false)
			if disembark is not Spaceport:
				disembark.energy -= 0.5

func move_false() -> void:
	await get_tree().create_timer(0.1/Game.move_speed).timeout
	moving = false
	position = Vector2(16*round(position.x/16), 16*round(position.y/16))

func shoot(dir: Vector2) -> void:
	var angle = dir.angle()
	%Turret.rotation = angle
	if shoot_allowed:
		disembark.energy -= 1
		var laser = laser_scene.instantiate()
		laser.position = position+Vector2(8,8)
		laser.rotation = angle
		disembark.get_node("Lasers").add_child(laser)
		shoot_allowed = false
		get_tree().create_timer(0.5).connect("timeout", reset_shot)

func reset_shot() -> void:
	shoot_allowed = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var pos = get_global_mouse_position()
		%Turret.rotation = (pos-(position+Vector2(8,8))).angle()
	if event.is_action_pressed("shoot"):
		var pos = get_global_mouse_position()
		shoot(pos-(position+Vector2(8,8)))

func _process(_delta: float) -> void:
	var dir = Input.get_vector(
		"shoot_left", "shoot_right", "shoot_up", "shoot_down"
	)
	if dir: shoot(dir)

func _on_collect_creatures_body_entered(body: Node2D) -> void:
	if body is Creature:
		disembark.overlay.add_collectible(body, body.ID)

func _on_collect_creatures_body_exited(body: Node2D) -> void:
	if body is Creature:
		disembark.overlay.remove_collectible(body)

func _on_collect_creatures_area_entered(area: Area2D) -> void:
	if area is Wreck:
		disembark.overlay.add_collectible(area, "wreck")

func _on_collect_creatures_area_exited(area: Area2D) -> void:
	if area is Wreck:
		disembark.overlay.remove_collectible(area)
