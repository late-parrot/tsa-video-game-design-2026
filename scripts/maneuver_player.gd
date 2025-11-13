extends CharacterBody2D


@onready var maneuver = $".."

@export var SPEED = 500.0
@export var ACCELERATION = 1200.0
@export var FRICTION = 800.0
@export var ROTATION_SPEED = 8.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if maneuver.back_to_spaceport:
		direction = position.direction_to(maneuver.spaceport.position)
	if direction:
		rotation = rotate_toward(rotation, direction.angle(), ROTATION_SPEED*delta)
		velocity = velocity.move_toward(direction*SPEED, ACCELERATION*delta)
		$Fire.emitting = true
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION*delta)
		$Fire.emitting = false

	move_and_slide()
