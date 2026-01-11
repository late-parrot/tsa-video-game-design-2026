extends Node

var names = {
	"debug": "Debug"
}

var ship_cargo = {}
var vehicle_cargo = {}

func move_cargo() -> void:
	for id in vehicle_cargo:
		if ship_cargo.has(id):
			ship_cargo[id] += vehicle_cargo[id]
		else:
			ship_cargo[id] = vehicle_cargo[id]
	vehicle_cargo.clear()
