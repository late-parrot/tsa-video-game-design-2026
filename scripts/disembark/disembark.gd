extends Node2D


@onready var player = $DisembarkPlayer
@onready var overlay = $UI/DisembarkOverlay

var energy = 100

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
	main.maneuver.land() # Seems a bit janky but works

func launch() -> void:
	var main = get_parent()
	main.add_child(main.maneuver)
	queue_free()
