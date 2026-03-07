# For control nodes that don't have a native focus,
# this can be used to apply focus along with
# focus_mode set to 'All'.

extends PanelContainer

var focus_box: StyleBox
var normal_box: StyleBox

func _ready():
	focus_box = StyleBoxFlat.new()
	focus_box.draw_center = false
	focus_box.border_color = Color.WHITE
	focus_box.set_border_width_all(2)
	
	normal_box = StyleBoxFlat.new()
	normal_box.draw_center = false
	normal_box.border_color = Color.TRANSPARENT
	normal_box.set_border_width_all(2)
	add_theme_stylebox_override("panel", normal_box)

func _on_focus_entered
