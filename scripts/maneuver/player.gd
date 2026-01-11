class_name ManeuverPlayer extends CharacterBody2D

@onready var maneuver = $".."

## The max speed of the player.
@export_range(0, 1000, 50, "suffix:px/s") var SPEED: int = 500
## The acceleration the player will feel until it reaches `SPEED`.
@export_range(0, 2000, 100, "suffix:px/s^2") var ACCELERATION: int = 1200
## The decceleration the player will feel until it stops moving.
@export_range(0, 2000, 100, "suffix:px/s^2") var FRICTION: int = 800
## How fast the player will rotate when making tight turns.
@export_range(0, 10, 1, "suffix:rad/s") var ROTATION_SPEED: float = 4.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if maneuver.back_to_spaceport:
		direction = position.direction_to(maneuver.spaceport.position)
	if direction:
		rotation = rotate_toward(rotation, direction.angle(), ROTATION_SPEED*delta)
		velocity = velocity.move_toward(direction*SPEED, ACCELERATION*delta)
		%Fire.emitting = true
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION*delta)
		%Fire.emitting = false

	move_and_slide()
