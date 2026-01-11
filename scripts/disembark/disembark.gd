class_name Disembark extends Node2D

## The maximum engergy that the terrain vehicle can hold. This is what it's reset to when
## recharged or landing.
@export_range(0, 500, 10) var MAX_ENERGY: int = 100

@onready var player = %DisembarkPlayer
@onready var overlay = %DisembarkOverlay

var energy = MAX_ENERGY:
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
	var main = get_parent()
	launch()
	main.maneuver.land(main.maneuver.current_planet) # Seems a bit janky but works

func recharge() -> void:
	Game.move_cargo()
	energy = MAX_ENERGY

func launch() -> void:
	Game.move_cargo()
	var main = get_parent()
	main.add_child(main.maneuver)
	main.maneuver.overlay.reset()
	queue_free()
