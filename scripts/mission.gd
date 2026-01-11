class_name Mission extends Object

enum MissionType {
	LAND, COLLECT
}

@export var name: String = "Mission"
@export var type: MissionType = MissionType.LAND
@export var required: int = 1
@export var criteria: Dictionary[String, Variant] = {}

signal complete

var progress = 0:
	set(v):
		progress = v
		if v >= required:
			_complete()

func _init(n: String, t: MissionType, r: int, c: Dictionary[String, Variant] = {}) -> void:
	name = n
	type = t
	required = r
	criteria = c

func _complete() -> void:
	Game.missions.erase(self)
	Game.main.overlay.show_mission_completed()
	emit_signal("complete")
