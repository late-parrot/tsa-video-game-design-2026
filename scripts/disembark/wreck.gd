@tool
class_name Wreck extends Area2D

@export var money: int
@export_range(0, 5) var type: int:
	set(v):
		@warning_ignore("integer_division")
		%Sprite.texture.region = Rect2(25*(v%2), 25*(v/2), 25, 25)
		type = v
