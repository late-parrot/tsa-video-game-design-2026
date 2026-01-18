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
		Mission.new("Land on a planet", Mission.MissionType.LAND, 1),
		Mission.new("Capture 3 creatures", Mission.MissionType.COLLECT, 3, {
			"type": preload("res://scripts/disembark/creature.gd")
		})
	],
	[
		Mission.new("Capture 5 creatures", Mission.MissionType.COLLECT, 5, {
			"type": preload("res://scripts/disembark/creature.gd")
		})
	]
]
var current_mission_set = 0
var missions = mission_sets[current_mission_set]

signal level_completed

func _process(_delta: float) -> void:
	if missions.is_empty():
		current_mission_set += 1
		missions = mission_sets[current_mission_set]
		emit_signal("level_completed")

func move_cargo() -> void:
	for id in vehicle_cargo:
		if ship_cargo.has(id):
			ship_cargo[id] += vehicle_cargo[id]
		else:
			ship_cargo[id] = vehicle_cargo[id]
	vehicle_cargo.clear()
