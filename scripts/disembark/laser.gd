class_name Laser extends Area2D

## The bullet's speed
@export_range(0, 300, 50, "suffix:px/s") var SPEED: int = 200
## Max distance from the player. After this, the bullet will self-destruct.
@export_range(0, 200, 50, "suffix:px") var DISTANCE: int = 70 # 20 more than creature's "run distance"

var distance = 0

func _physics_process(delta: float) -> void:
	position += SPEED*delta*Vector2.from_angle(rotation)
	distance += SPEED*delta
	if distance > DISTANCE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer or body is Creature:
		queue_free()
