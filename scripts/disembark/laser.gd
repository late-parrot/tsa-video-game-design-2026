class_name Laser extends Area2D

@export var SPEED = 200.0
@export var DISTANCE = 70.0 # 20 more than creature's "run distance"
var distance = 0

func _physics_process(delta: float) -> void:
	position += SPEED*delta*Vector2.from_angle(rotation)
	distance += SPEED*delta
	if distance > DISTANCE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
