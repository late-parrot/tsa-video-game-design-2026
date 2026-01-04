class_name InputController extends Node

@export_category("Overrides")
@export var MOVE = false
@export var SHOOT = false
@export var BUMPERS = true

func _unhandled_input(event: InputEvent) -> void:
	var press = false
	var ui_event = InputEventAction.new()
	ui_event.pressed = true
	var prefixes = []
	if MOVE: prefixes.append("")
	if SHOOT: prefixes.append("shoot_")
	for x in prefixes:
		for y in ["up", "down", "left", "right"]:
			if event.is_action_pressed(x+y):
				ui_event.action = "ui_"+y
				press = true
	if BUMPERS:
		if event.is_action_pressed("left_bumper"):
			ui_event.action = "ui_focus_prev"
			press = true
		elif event.is_action_pressed("right_bumper"):
			ui_event.action = "ui_focus_next"
			press = true
	if press:
		Input.parse_input_event(ui_event)
