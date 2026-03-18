extends CanvasLayer


const SPEED = 50.0
var scrolling = false

func _process(delta: float) -> void:
	if scrolling:
		%RichTextLabel.get_child(0, true).value += delta*SPEED
