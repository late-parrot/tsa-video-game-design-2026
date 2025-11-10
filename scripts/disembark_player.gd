extends CharacterBody2D


@export var SPEED = 100.0
@export var ACCELERATION = 1000.0
@export var FRICTION = 300.0
@export var ROTATION_SPEED = 6.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction:
		rotation = rotate_toward(rotation, direction.angle(), ROTATION_SPEED*delta)
	if direction and is_equal_approx(rotation, direction.angle()):
		velocity = velocity.move_toward(direction*SPEED, ACCELERATION*delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	move_and_slide()

#####################
##  GRID MOVEMENT  ##
#####################

#const TILE_SIZE = 16
#var moving = false
#
#func _physics_process(_delta: float) -> void:
	#if not moving:
		#var d := Input.get_vector("left", "right", "up", "down")
		## Set the vector to whichever direction is strongest
		#d = Vector2(sign(d.x), 0) if abs(d.x) > abs(d.y) \
			#else Vector2(0, sign(d.y))
		#if d:
			#var collision = move_and_collide(d*TILE_SIZE, true)
			#if collision:
				#return
			#moving = true
			#var tween = create_tween()
			#tween.set_ease(Tween.EASE_IN_OUT)
			#tween.tween_property(self, "position", position+d*TILE_SIZE, 0.1)
			#tween.tween_callback(move_false)
#
#func move_false() -> void:
	#await get_tree().create_timer(0.05).timeout
	#moving = false
	#position = Vector2(16*round(position.x/16), 16*round(position.y/16))
