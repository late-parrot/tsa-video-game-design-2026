class_name Main extends Node2D

@onready var overlay = %GlobalOverlay

var maneuver = preload("res://scenes/maneuver/maneuver.tscn").instantiate()

func _ready() -> void:
	add_child(maneuver)
	Game.connect("level_completed", overlay.show_level_completed)
	for s in Game.mission_sets:
		for m in s:
			m.connect("complete", overlay.show_mission_completed)
