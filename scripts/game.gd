extends Node

var names = {
	"debug": "Debug"
}
var ship_cargo = {}
var vehicle_cargo = {}
var missions = [
	Mission.new("Land on a planet", Mission.MissionType.LAND, 1),
	Mission.new("Capture 3 creatures", Mission.MissionType.COLLECT, 3, {
		"type": preload("res://scripts/disembark/creature.gd")
	})
]

@onready var main = $"/root/Main"

func move_cargo() -> void:
	for id in vehicle_cargo:
		if ship_cargo.has(id):
			ship_cargo[id] += vehicle_cargo[id]
		else:
			ship_cargo[id] = vehicle_cargo[id]
	vehicle_cargo.clear()
