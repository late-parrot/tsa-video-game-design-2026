extends Node

var scene_transition

var cache = {
	"sun_SpriteFrames": preload("res://resources/sun_SpriteFrames.tres")
}

var names = {
	"debug": "Debug",
	"snake": "Snake",
	"bug": "Bug",
	"rabbit": "Rabbit"
}
var ship_cargo = {}
var vehicle_cargo = {}
var mission_sets := [
	[
		Mission.new(0, "Land on a planet", Mission.MissionType.LAND, 1, 5),
		Mission.new(1, "Capture 3 creatures", Mission.MissionType.COLLECT, 3, 5, {
			"type": preload("res://scripts/disembark/creature.gd")
		})
	],
	[
		Mission.new(2, "Capture 5 creatures", Mission.MissionType.COLLECT, 5, 10, {
			"type": preload("res://scripts/disembark/creature.gd")
		})
	]
]
var current_mission_set = 0
var missions = mission_sets[current_mission_set]

var upgrades = null
var research_rewards = [5, 10, 15, 20, 25]
var research_reqs = [3, 5, 8, 10, 15]
var max_research = 5
var research_levels = {"snake": 0, "bug": 0, "rabbit": 0}
var research_times = {"snake": 0, "bug": 0, "rabbit": 0}
var money = 0

var net_distance = 70 # 20 more than the enemie's run distance
var net_accuracy = 1
var max_energy = 100
var move_speed = 1
var reward_amount = 1

var won = false

signal level_completed
signal win

func _process(delta: float) -> void:
	if won: return
	if missions.is_empty():
		current_mission_set += 1
		if current_mission_set >= len(mission_sets):
			emit_signal("win")
			won = true
		else:
			missions = mission_sets[current_mission_set]
		emit_signal("level_completed")
	for id in research_times:
		if research_times[id] > 0:
			research_times[id] -= delta
			if research_times[id] <= 0:
				research_times[id] = 0
				money += research_rewards[research_levels[id]]
				research_levels[id] += 1

func move_cargo() -> void:
	for id in vehicle_cargo:
		if ship_cargo.has(id):
			ship_cargo[id] += vehicle_cargo[id]
		else:
			ship_cargo[id] = vehicle_cargo[id]
	vehicle_cargo.clear()
