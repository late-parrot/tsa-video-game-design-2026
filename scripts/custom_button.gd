@tool
class_name CustomButton extends PanelContainer

@export var disabled: bool = false

@export_category("Styles")
@export var NORMAL: StyleBox
@export var HOVER: StyleBox
@export var PRESSED: StyleBox
@export var FOCUSED: StyleBox
@export var FOCUSED_HOVER: StyleBox
@export var FOCUSED_PRESSED: StyleBox
@export var FOCUSED_DISABLED: StyleBox
@export var DISABLED: StyleBox

signal pressed

var default_theme = preload("res://resources/theme.tres")

var hovered = false
var is_pressed = false
var focused = false

func _init() -> void:
	if Engine.is_editor_hint():
		NORMAL = default_theme.get_stylebox("Button", "normal")
		HOVER = default_theme.get_stylebox("Button", "hover")
		PRESSED = default_theme.get_stylebox("Button", "pressed")
		FOCUSED = default_theme.get_stylebox("Button", "focus")
		FOCUSED_HOVER = default_theme.get_stylebox("Button", "normal")
		FOCUSED_PRESSED = default_theme.get_stylebox("Button", "normal")
		FOCUSED_DISABLED = default_theme.get_stylebox("Button", "normal")
		DISABLED = default_theme.get_stylebox("Button", "disabled")
		focus_mode = Control.FOCUS_ALL

func set_style(style_box: StyleBox) -> void:
	add_theme_stylebox_override("panel", style_box)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	if focused:
		set_style(FOCUSED_DISABLED if disabled else FOCUSED_PRESSED if is_pressed
		else FOCUSED_HOVER if hovered else FOCUSED)
	else:
		set_style(DISABLED if disabled else PRESSED if is_pressed else HOVER if hovered else NORMAL)
	if Input.is_action_just_pressed("ui_accept") and focused or Input.is_action_just_pressed("click") and hovered:
		emit_signal("pressed")

func _on_mouse_entered() -> void:
	hovered = true

func _on_mouse_exited() -> void:
	hovered = false

func _on_focus_entered() -> void:
	focused = true

func _on_focus_exited() -> void:
	focused = false

func _on_pressed() -> void:
	print("click!")
