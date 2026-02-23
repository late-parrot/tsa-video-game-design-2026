class_name Laser extends Area2D

@onready var disembark = $"../.."

## The bullet's speed
@export_range(0, 300, 50, "suffix:px/s") var SPEED: int = 200

var distance = 0

func _physics_process(delta: float) -> void:
	position += SPEED*delta*Vector2.from_angle(rotation)
	distance += SPEED*delta
	if distance > Game.net_distance:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer or body is Creature:
		queue_free()
		disembark.camera.add_trauma()
