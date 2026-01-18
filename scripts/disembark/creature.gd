class_name Creature extends CharacterBody2D

## The ID of this creature as used by inventory, missions, and other systems.
## Must be identical to other creatures of the same type. Case sensitive.
@export var ID: String = "debug"
## The speed the creature will travel when running away from the player.
## Should be quite a bit faster than the player so that they need to run and catch up.
@export_range(0, 300, 50, "suffix:px/s") var RUN_SPEED: int = 100
## The distance from the player that the creature will run to before it deems itself safe.
@export_range(0, 500, 50, "suffix:px", "description:The") var DISTANCE: int = 300
## The chance this creature will be captured by any given shot. Works a bit like Pokemon,
## should be lower for tougher enemies.
@export_range(0, 1, 0.05) var CAPTURE_CHANCE: float = 0.2
## The time the creature will stay captured before it will escape. The player has this
## long to collect it.
@export_range(0, 10, 1, "suffix:s") var CAPTURE_TIME: float = 3.0

var avoiding = false
var avoid_pos: Vector2
var captured = false

@onready var agent: NavigationAgent2D = %NavigationAgent2D
@onready var disembark: Disembark = $"../.."

func _physics_process(_delta: float) -> void:
	if captured:
		%Sprite.play("captured")
		return
	if not avoiding:
		%Sprite.play("idle")
		return
	agent.target_position = (position-avoid_pos).normalized()*DISTANCE+avoid_pos
	
	var current_agent_pos = global_position
	var next_path_pos = agent.get_next_path_position()
	var new_vel = current_agent_pos.direction_to(next_path_pos)*RUN_SPEED
	
	if agent.is_navigation_finished():
		avoiding = false
		return
	
	if agent.avoidance_enabled:
		agent.set_velocity(new_vel)
	else:
		_on_navigation_agent_2d_velocity_computed(new_vel)
	move_and_slide()
	
	if velocity:
		%Sprite.flip_v = 1 if velocity.x < 0 else 0
		%Sprite.play("run")
	rotation = velocity.angle()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func _on_start_running_body_entered(body: Node2D) -> void:
	if body == disembark.player:
		avoiding = true
		avoid_pos = disembark.player.position+Vector2(8,8)

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area is Laser:
		if randf() <= CAPTURE_CHANCE:
			capture()

func capture():
	captured = true
	scale = 0.8*Vector2.ONE # TODO: remove
	await get_tree().create_timer(CAPTURE_TIME).timeout
	captured = false
	scale = Vector2.ONE # TODO: remove
