class_name Maneuver extends Node2D

@export var spaceport: Planet
var back_to_spaceport = false
var current_planet = null

@onready var player = $ManeuverPlayer
@onready var overlay = $UI/ManeuverOverlay

func enable_land() -> void:
	overlay.enable_land()

func disable_land() -> void:
	overlay.disable_land()
	
func land(planet: Planet) -> void:
	player.velocity = Vector2.ZERO
	var main = get_parent()
	var disembark = planet.create_disembark_scene()
	main.add_child(disembark)
	main.remove_child(self)

func _process(_delta: float) -> void:
	overlay.set_xy(player.position.x/64, -player.position.y/64)
