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

func transition():
	$SceneTransition.transition()
