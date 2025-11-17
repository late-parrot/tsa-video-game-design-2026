extends Area2D


@onready var maneuver = $"../.."

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if self == maneuver.spaceport and maneuver.back_to_spaceport:
			await get_tree().create_timer(0.2).timeout
			maneuver.land()
		maneuver.enable_land()

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		maneuver.disable_land()
