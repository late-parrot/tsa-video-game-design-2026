extends Control

@onready var initial_ship_pos = %Ship.position
@onready var initial_ship_rot = %Ship.rotation

func _ready() -> void:
	%Sun.sprite_frames = Game.cache["sun_SpriteFrames"]
	%Sun.play()
	_on_ship_moved()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_ship_moved() -> void:
	await get_tree().create_timer(0.5).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(%Ship, "position",
		initial_ship_pos+Vector2(randf_range(-10,10), randf_range(-10,10)), 2)
	tween.tween_property(%Ship, "rotation", initial_ship_rot+randf_range(-.1,.1), 3)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(_on_ship_moved)
