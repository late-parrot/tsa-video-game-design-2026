class_name Main extends Node2D

@onready var overlay = %GlobalOverlay

var maneuver = preload("res://scenes/maneuver/maneuver.tscn").instantiate()

func _ready() -> void:
	add_child(maneuver)
