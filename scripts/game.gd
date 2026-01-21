extends Node

var names = {
	"debug": "Debug",
	"snake": "Snake",
	"bug": "Bug"
}
var ship_cargo = {}
var vehicle_cargo = {}
var mission_sets := [
	[
		Mission.new("Land on a planet", Mission.MissionType.LAND, 1, 5),
		Mission.new("Capture 3 creatures", Mission.MissionType.COLLECT, 3, 5, {
			"type": preload("res://scripts/disembark/creature.gd")
		})
	],
	[
		Mission.new("Capture 5 creatures", Mission.MissionType.COLLECT, 5, 10, {
			"type": preload("res://scripts/disembark/creature.gd")
		})
	]
]
var current_mission_set = 0
var missions = mission_sets[current_mission_set]

var upgrades = null
var money = 0

var net_distance = 70 # 20 more than the enemie's run distance
var net_accuracy = 1
var max_energy = 100
var move_speed = 1
var reward_amount = 1

signal level_completed

func _process(_delta: float) -> void:
	if missions.is_empty():
		current_mission_set += 1
		if current_mission_set >= len(mission_sets):
			win()
			return
		missions = mission_sets[current_mission_set]
		emit_signal("level_completed")

func move_cargo() -> void:
	for id in vehicle_cargo:
		if ship_cargo.has(id):
			ship_cargo[id] += vehicle_cargo[id]
		else:
			ship_cargo[id] = vehicle_cargo[id]
	vehicle_cargo.clear()

func win() -> void:
	pass
