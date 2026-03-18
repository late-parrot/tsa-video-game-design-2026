class_name Maneuver extends Node2D

## The planet that the "Back to Spaceport" button will navigate to.
@export var spaceport: Planet

var back_to_spaceport = false
var current_planet = null

@onready var player = %ManeuverPlayer
@onready var overlay = %ManeuverOverlay

func _ready() -> void:
	%Sun.sprite_frames = Game.cache["sun_SpriteFrames"]
	%Sun.play()
	overlay.reset()

func enable_land() -> void:
	overlay.enable_land()

func disable_land() -> void:
	overlay.disable_land()
	
func land(planet: Planet, transition: bool = true) -> void:
	player.velocity = Vector2.ZERO
	for m in Game.missions:
		if m.type == Mission.MissionType.LAND and planet.name == m.criteria["planet"]:
			m.progress += 1
	var main = get_parent()
	var disembark = planet.create_disembark_scene()
	if transition:
		Game.scene_transition.transition()
		await Game.scene_transition.change_scene
	main.add_child(disembark)
	main.remove_child(self)
	if main.tutorial.step == 6:
		main.tutorial.next()
		spaceport.unlock()
	if main.tutorial.step == 17 and planet == spaceport:
		main.tutorial.next()

func _process(_delta: float) -> void:
	overlay.set_xy(player.position.x/64, -player.position.y/64)
