extends Control

@onready var maneuver := $"../.."

func set_xy(x: int, y: int) -> void:
	$Container/MarginContainer/VBoxContainer/XY/X.text = "X:"+str(x)
	$Container/MarginContainer/VBoxContainer/XY/Y.text = "Y:"+str(y)

func enable_land() -> void:
	$Container/MarginContainer/VBoxContainer/Land.disabled = false

func disable_land() -> void:
	$Container/MarginContainer/VBoxContainer/Land.disabled = true

func show_name(planet_name: String) -> void:
	$NameBanner/MarginContainer/Label.text = planet_name
	$NameBanner.visible = true

func hide_name() -> void:
	$NameBanner.visible = false

func reset() -> void:
	var vbox = $Container/MarginContainer/VBoxContainer
	vbox.get_node("Land").grab_focus()
	vbox.get_node("BackToSpaceport").button_pressed = false

func _on_land_pressed() -> void:
	maneuver.land(maneuver.current_planet)

func _on_back_to_spaceport_toggled(toggled_on: bool) -> void:
	maneuver.back_to_spaceport = toggled_on
	if toggled_on and maneuver.player in \
			maneuver.spaceport.get_overlapping_bodies():
		maneuver.land(maneuver.spaceport)
