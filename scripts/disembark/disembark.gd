class_name Disembark extends Node2D

@onready var player = %DisembarkPlayer
@onready var overlay = %DisembarkOverlay
@onready var camera = %Camera

var energy = Game.max_energy:
	set(value):
		energy = value
		if energy < 0:
			reset()

func _process(_delta: float) -> void:
	overlay.set_xy(player.position.x/16, -player.position.y/16)
	overlay.set_energy(energy)

func _on_ship_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		overlay.enable_launch()

func _on_ship_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		overlay.disable_launch()

func reset() -> void:
	Game.vehicle_cargo.clear()
	var main = get_parent()
	Game.scene_transition.transition()
	await Game.scene_transition.change_scene
	launch(false)
	main.maneuver.land(main.maneuver.current_planet, false) # Seems a bit janky but works

func recharge() -> void:
	Game.move_cargo()
	energy = Game.max_energy

func launch(transition: bool = true) -> void:
	Game.move_cargo()
	var main = get_parent()
	if transition:
		Game.scene_transition.transition()
		await Game.scene_transition.change_scene
	main.add_child(main.maneuver)
	main.maneuver.overlay.reset()
	queue_free()
	if main.tutorial.step == 16:
		main.tutorial.previous_focus = main.maneuver.overlay.get_node("%BackToSpaceport")
		main.tutorial.next()
