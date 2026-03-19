class_name Mission extends Object

enum MissionType {
	LAND, COLLECT, RESEARCH, UPGRADE
}

@export var id: int = 0
@export var name: String = "Mission"
@export var type: MissionType = MissionType.LAND
@export var required: int = 1
@export var reward: int = 0
@export var criteria: Dictionary[String, Variant] = {}

signal complete

var progress = 0:
	set(v):
		progress = v
		if v >= required:
			_complete()

func _init(i: int, n: String, t: MissionType, r: int, rw: int, c: Dictionary[String, Variant] = {}) -> void:
	id = i
	name = n
	type = t
	required = r
	reward = rw
	criteria = c

func _complete() -> void:
	Game.missions.erase(self)
	Game.money += floor(reward*Game.reward_amount)
	emit_signal("complete")
