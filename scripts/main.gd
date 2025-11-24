class_name Main extends Node2D

var maneuver = preload("res://scenes/maneuver/maneuver.tscn").instantiate()

func _ready() -> void:
	add_child(maneuver)
