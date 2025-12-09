class_name Creature extends CharacterBody2D

@export var SPEED = 100.0
@export var DISTANCE = 300.0
var avoiding = false
var avoid_pos: Vector2

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var disembark: Disembark = $"../.."

func _physics_process(_delta: float) -> void:
	if not avoiding: return
	agent.target_position = (position-avoid_pos).normalized()*DISTANCE+avoid_pos
	
	var current_agent_pos = global_position
	var next_path_pos = agent.get_next_path_position()
	var new_vel = current_agent_pos.direction_to(next_path_pos)*SPEED
	
	if agent.is_navigation_finished():
		avoiding = false
		return
	
	if agent.avoidance_enabled:
		agent.set_velocity(new_vel)
	else:
		_on_navigation_agent_2d_velocity_computed(new_vel)
	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func _on_start_running_body_entered(body: Node2D) -> void:
	if body == disembark.player:
		avoiding = true
		avoid_pos = disembark.player.position+Vector2(8,8)
