class_name Main extends Node2D

@onready var overlay = %GlobalOverlay
@onready var tutorial = %Tutorial

var maneuver = preload("res://scenes/maneuver/maneuver.tscn").instantiate()
var credits_scene = preload("res://scenes/credits.tscn")

func _ready() -> void:
	Game.scene_transition = $SceneTransition
	Game.connect("win", credits)

func start() -> void:
	add_child(maneuver)
	Game.connect("level_completed", overlay.show_level_completed)
	Game.connect("level_completed", _on_level_completed)
	for s in Game.mission_sets:
		for m in s:
			m.connect("complete", overlay.show_mission_completed)
			if m.id == 1:
				m.connect("complete", tutorial.next)
	tutorial.next()

func credits() -> void:
	transition()
	await Game.scene_transition.change_scene
	var node = credits_scene.instantiate()
	for c in get_children():
		if c.name not in ["AudioStreamPlayer", "SceneTransition"]:
			c.queue_free()
	add_child(node)
	await Game.scene_transition.get_node("%AnimationPlayer").animation_finished
	node.scrolling = true

func transition() -> void:
	$SceneTransition.transition()

func _on_level_completed() -> void:
	if Game.current_mission_set == 1:
		maneuver.get_node("Planets").get_child(3).unlock()
	elif Game.current_mission_set == 2:
		maneuver.get_node("Planets").get_child(4).unlock()
