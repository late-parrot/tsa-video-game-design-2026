extends Node2D


func enable_land() -> void:
	$UI/ManeuverOverlay.enable_land()

func disable_land() -> void:
	$UI/ManeuverOverlay.disable_land()
	
func land() -> void:
	get_tree().quit()
