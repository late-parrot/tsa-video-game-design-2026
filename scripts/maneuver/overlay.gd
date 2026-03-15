extends Control

@onready var maneuver := $"../.."

func _process(_delta: float) -> void:
	%Level.set_text("Level "+str(Game.current_mission_set+1))
	
	for m in %Missions.get_children():
		if m.visible: m.queue_free()
	for m in Game.missions:
		var node = %Mission.duplicate()
		node.visible = true
		node.get_node("Name").set_text(m.name)
		var pb = node.get_node("HBox/ProgressBar")
		pb.max_value = m.required
		pb.value = m.progress
		node.get_node("HBox/Progress").set_text(str(m.progress)+"/"+str(m.required))
		node.get_node("HBox/HBox/Reward").set_text(str(m.reward))
		%Missions.add_child(node)
	
	%Money.text = str(Game.money)

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

func disable_back_to_spaceport() -> void:
	%BackToSpaceport.button_pressed = false

func _on_land_pressed() -> void:
	maneuver.land(maneuver.current_planet)

func _on_back_to_spaceport_toggled(toggled_on: bool) -> void:
	maneuver.back_to_spaceport = toggled_on
	if toggled_on and maneuver.player in \
			maneuver.spaceport.get_overlapping_bodies() and maneuver.spaceport.landable:
		maneuver.land(maneuver.spaceport)
