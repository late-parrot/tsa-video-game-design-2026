extends Control

func show_mission_completed() -> void:
	%MissionCompletedBanner.visible = true
	await get_tree().create_timer(2).timeout
	%MissionCompletedBanner.visible = false

func show_level_completed() -> void:
	%LevelCompletedBanner.visible = true
	await get_tree().create_timer(2).timeout
	%LevelCompletedBanner.visible = false

func show_cargo_moved() -> void:
	%CargoMovedBanner.visible = true
	await get_tree().create_timer(2).timeout
	%CargoMovedBanner.visible = false

func show_wreck_collected(v) -> void:
	%WreckCollectedLabel.text = "Found "+str(v)
	%WreckCollectedBanner.visible = true
	await get_tree().create_timer(2).timeout
	%WreckCollectedBanner.visible = false
