extends CharacterBody2D


@export var SPEED = 500.0
@export var ACCELERATION = 1200.0
@export var FRICTION = 800.0
@export var ROTATION_SPEED = 8.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction:
		rotation = rotate_toward(rotation, direction.angle(), ROTATION_SPEED*delta)
		velocity = velocity.move_toward(direction*SPEED, ACCELERATION*delta)
		$GPUParticles2D.emitting = true
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION*delta)
		$GPUParticles2D.emitting = false

	move_and_slide()
