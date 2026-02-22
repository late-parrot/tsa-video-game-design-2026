class_name Planet extends Area2D

## Is this planet landable? The sun is a `Planet` object, but clearly not landable, or you
## can functionally lock planets this way.
@export var landable: bool = true
## The scene that will be used when disembarking on this `Planet`. Should inherit `Disembark`
## and contain the necessary UI, player, and other logic. Duplicate an existing planet scene
## if you would like to create a new planet.
@export var disembark_scene: PackedScene = \
	preload("res://scenes/disembark/disembark.tscn")

@onready var maneuver = $"../.."

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func create_disembark_scene() -> Node2D:
	return disembark_scene.instantiate()

func lock() -> void:
	if not name.contains("(Locked)"):
		name += " (Locked)"
	landable = false

func unlock() -> void:
	if name.contains("(Locked)"):
		name = name.replace(" (Locked)", "")
	landable = true

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if landable:
			maneuver.current_planet = self
			if self == maneuver.spaceport and maneuver.back_to_spaceport:
				await get_tree().create_timer(0.2).timeout
				maneuver.land(self)
			maneuver.enable_land()
		if self == maneuver.spaceport:
			maneuver.overlay.disable_back_to_spaceport()
		maneuver.overlay.show_name(name)

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		if landable:
			maneuver.disable_land()
		maneuver.overlay.hide_name()
