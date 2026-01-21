class_name InputController extends Node

@export_category("Overrides")
@export var MOVE = false
@export var SHOOT = false
@export var BUMPERS = true

func _process(_delta: float) -> void:
	var press = false
	var ui_event = InputEventAction.new()
	ui_event.pressed = true
	var prefixes = []
	if MOVE: prefixes.append("")
	if SHOOT: prefixes.append("shoot_")
	for x in prefixes:
		for y in ["up", "down", "left", "right"]:
			if Input.is_action_just_pressed(x+y):
				ui_event.action = "ui_"+y
				press = true
	if BUMPERS:
		if Input.is_action_just_pressed("left_bumper"):
			ui_event.action = "ui_focus_prev"
			press = true
		elif Input.is_action_just_pressed("right_bumper"):
			ui_event.action = "ui_focus_next"
			press = true
	if press:
		Input.parse_input_event(ui_event)
