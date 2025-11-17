extends Control


@onready var disembark := $"../.."

func set_xy(x: int, y: int) -> void:
	$Container/MarginContainer/VBoxContainer/XY/X.text = "X:"+str(x)
	$Container/MarginContainer/VBoxContainer/XY/Y.text = "Y:"+str(y)
	
func set_energy(percentage: int) -> void:
	var e = $Container/MarginContainer/VBoxContainer/Energy
	e.text = "Energy:"+str(percentage)+"%"
	e.label_settings.font_color = \
		Color(1.0, 1.0, 1.0, 1.0) if percentage > 50 else \
		Color(1.0, 0.861, 0.445, 1.0) if percentage > 25 else \
		Color(1.0, 0.293, 0.293, 1.0) if percentage > 10 else \
		Color(0.828, 0.129, 0.129, 1.0)

func enable_launch() -> void:
	$Container/MarginContainer/VBoxContainer/Launch.disabled = false

func disable_launch() -> void:
	$Container/MarginContainer/VBoxContainer/Launch.disabled = true

func _on_launch_pressed() -> void:
	disembark.launch()
