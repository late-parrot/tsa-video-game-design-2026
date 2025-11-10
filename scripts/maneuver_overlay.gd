extends Control


@onready var maneuver = $"../.."

func enable_land() -> void:
	$Container/MarginContainer/VBoxContainer/Land.disabled = false

func disable_land() -> void:
	$Container/MarginContainer/VBoxContainer/Land.disabled = true

func _on_land_pressed() -> void:
	maneuver.land()
