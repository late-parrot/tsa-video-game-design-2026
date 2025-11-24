class_name Planet extends Area2D

@export var disembark_scene: PackedScene = \
	preload("res://scenes/disembark/disembark.tscn")

@onready var maneuver = $"../.."

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	
func create_disembark_scene() -> Node2D:
	return disembark_scene.instantiate()
	
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		maneuver.current_planet = self
		if self == maneuver.spaceport and maneuver.back_to_spaceport:
			await get_tree().create_timer(0.2).timeout
			maneuver.land(self)
		maneuver.enable_land()

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		maneuver.disable_land()
