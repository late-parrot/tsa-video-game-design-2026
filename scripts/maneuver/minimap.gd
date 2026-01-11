extends Node2D

const SCALE = 1.0/4.0
@onready var overlay = $"../../../.."
var maneuver

func _ready() -> void:
	%Window.custom_minimum_size = \
		Vector2(1152*SCALE, 648*SCALE)
	await overlay.ready
	maneuver = overlay.maneuver
	var ps = maneuver.get_node("Planets").get_children()
	ps.reverse()
	for p in ps:
		var area = p.duplicate()
		var node = area.get_node("Sprite2D")
		area.remove_child(node)
		node.position = area.position*SCALE
		node.name = area.name
		node.scale = Vector2(SCALE, SCALE)
		var orbit = %Orbit.duplicate()
		orbit.get_child(0).scale = \
			Vector2(node.position.length(), node.position.length())
		orbit.get_child(1).scale = \
			Vector2(node.position.length()-8, node.position.length()-8)
		orbit.visible = true
		node.add_child(orbit)
		%Planets.add_child(node)

func _process(_delta: float) -> void:
	%Camera2D.position = maneuver.player.position*SCALE
