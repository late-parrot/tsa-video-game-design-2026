@tool
class_name Tutorial extends Control

var previous_focus = null

@export var step: int:
	set(v):
		print(v, previous_focus)
		step = v
		for c in get_children():
			c.visible = false
		if previous_focus != null:
			previous_focus.grab_focus()
		mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED
		if v >= 0 and v < get_child_count():
			var node = get_child(v)
			node.visible = true
			if not Engine.is_editor_hint():
				node.get_node("AnimationPlayer").play("advance_text")
				if node.has_node("Panel/Margin/HBox/NextButton"):
					previous_focus = get_viewport().gui_get_focus_owner()
					node.get_node("Panel/Margin/HBox/NextButton").grab_focus()
				if node.block_input:
					mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_ENABLED
					previous_focus.release_focus()
				if node.has_node("Timer"):
					node.get_node("Timer").start()

func _validate_property(property: Dictionary) -> void:
	if property.name == "step":
		property.hint = PROPERTY_HINT_RANGE
		property.hint_string = "-1,%d,1" % (get_child_count()-1)

func _ready() -> void:
	if not Engine.is_editor_hint():
		step = -1

func next() -> void:
	step += 1

func go_to(s: int) -> void:
	step = s

func _on_next_button_pressed() -> void:
	next()
	
func _on_timer_timeout() -> void:
	next()

func _input(event: InputEvent) -> void:
	if (event.is_action("up") or event.is_action("down") or \
		event.is_action("left") or event.is_action("right")) and (step == 2 or step == 8):
		next()
	if (event.is_action("shoot_up") or event.is_action("shoot_down") or \
		event.is_action("shoot_left") or event.is_action("shoot_right") or \
		event.is_action("shoot")) and step == 10:
		next()
