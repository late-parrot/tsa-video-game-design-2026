extends Control

@onready var maneuver := $"../.."

func set_xy(x: int, y: int) -> void:
	%X.text = "X:"+str(x)
	%Y.text = "Y:"+str(y)

func enable_land() -> void:
	%Land.disabled = false

func disable_land() -> void:
	%Land.disabled = true

func show_name(planet_name: String) -> void:
	%NameBanner/MarginContainer/Label.text = planet_name
	%NameBanner.visible = true

func hide_name() -> void:
	%NameBanner.visible = false

func reset() -> void:
	%Land.grab_focus()
	%BackToSpaceport.button_pressed = false

func _on_land_pressed() -> void:
	maneuver.land(maneuver.current_planet)

func _on_back_to_spaceport_toggled(toggled_on: bool) -> void:
	maneuver.back_to_spaceport = toggled_on
	if toggled_on and maneuver.player in \
			maneuver.spaceport.get_overlapping_bodies():
		maneuver.land(maneuver.spaceport)
