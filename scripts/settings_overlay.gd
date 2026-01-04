class_name SettingsOverlay extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_bumper"):
		if %TabContainer.current_tab-1 < 0:
			%TabContainer.current_tab = %TabContainer.get_tab_count()-1
		else:
			%TabContainer.current_tab -= 1
	if event.is_action_pressed("right_bumper"):
		if %TabContainer.current_tab+1 >= %TabContainer.get_tab_count():
			%TabContainer.current_tab = 0
		else:
			%TabContainer.current_tab += 1
