extends Control


@onready var maneuver := $"../.."

func set_xy(x: int, y: int) -> void:
	$Container/MarginContainer/VBoxContainer/XY/X.text = "X:"+str(x)
	$Container/MarginContainer/VBoxContainer/XY/Y.text = "Y:"+str(y)

func enable_land() -> void:
	$Container/MarginContainer/VBoxContainer/Land.disabled = false

func disable_land() -> void:
	$Container/MarginContainer/VBoxContainer/Land.disabled = true

func _on_land_pressed() -> void:
	maneuver.land()

func _on_back_to_spaceport_toggled(toggled_on: bool) -> void:
	maneuver.back_to_spaceport = toggled_on
	if toggled_on and maneuver.player in \
			maneuver.spaceport.get_overlapping_bodies():
		maneuver.land()
