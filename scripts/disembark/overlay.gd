extends Control

@onready var disembark := $"../.."
@onready var main := $"../../.."

var collectibles = []

func _process(_delta: float) -> void:
	%Level.set_text("Level "+str(Game.current_mission_set+1))
	
	%Cargo.clear()
	%Cargo.append_text("Terrain Vehicle\n")
	if len(Game.vehicle_cargo)==0:
		%Cargo.append_text("  Empty")
	for item in Game.vehicle_cargo:
		var count = Game.vehicle_cargo[item]
		%Cargo.append_text("[ul]"+str(count)+" "+Game.names[item]+("s" if count!=1 else "")+"[/ul]")
	%Cargo.append_text("\n\nShip\n")
	if len(Game.ship_cargo)==0:
		%Cargo.append_text("  Empty")
	for item in Game.ship_cargo:
		var count = Game.ship_cargo[item]
		%Cargo.append_text("[ul]"+str(count)+" "+Game.names[item]+("s" if count!=1 else "")+"[/ul]")
	
	# Godot doesn't seem to like the disabled value changing more than once per frame
	var d = true
	for c in collectibles:
		if c["node"] is not Creature or c["node"].captured:
			d = false
	%Collect.disabled = d
	
	for m in %Missions.get_children():
		if m.visible: m.queue_free()
	for m in Game.missions:
		var node = %Mission.duplicate()
		node.visible = true
		node.get_node("Name").set_text(m.name)
		var pb = node.get_node("HBox/ProgressBar")
		pb.max_value = m.required
		pb.value = m.progress
		node.get_node("HBox/Progress").set_text(str(m.progress)+"/"+str(m.required))
		node.get_node("HBox/HBox/Reward").set_text(str(m.reward))
		%Missions.add_child(node)

func set_xy(x: int, y: int) -> void:
	%X.text = "X:"+str(x)
	%Y.text = "Y:"+str(y)
	
func set_energy(percentage: int) -> void:
	%Energy.text = "Energy:"+str(percentage)+"%"
	%Energy.label_settings.font_color = \
		Color(1.0, 1.0, 1.0, 1.0) if percentage > 50 else \
		Color(1.0, 0.861, 0.445, 1.0) if percentage > 25 else \
		Color(1.0, 0.293, 0.293, 1.0) if percentage > 10 else \
		Color(0.828, 0.129, 0.129, 1.0)
	%LowEnergyBanner.visible = percentage <= 25

func enable_launch() -> void:
	%Launch.disabled = false
	%Recharge.disabled = false

func disable_launch() -> void:
	%Launch.disabled = true
	%Recharge.disabled = true

func _on_launch_pressed() -> void:
	disembark.launch()
	main.overlay.show_cargo_moved()

func _on_recharge_pressed() -> void:
	disembark.recharge()
	main.overlay.show_cargo_moved()

func add_collectible(collectible, id: String) -> void:
	collectibles.append({"id":id, "node":collectible})

func remove_collectible(collectible) -> void:
	for c in collectibles:
		if c["node"] == collectible:
			collectibles.erase(c)

func _on_collect_pressed() -> void:
	var col = null
	for c in collectibles:
		if c["node"] is not Creature or c["node"].captured:
			col = c
	if col == null: return
	var n = col["id"]
	if Game.vehicle_cargo.has(n):
		Game.vehicle_cargo[n] += 1
	else:
		Game.vehicle_cargo[n] = 1
	for m in Game.missions:
		if m.type == Mission.MissionType.COLLECT and \
			(not m.criteria.has("type") or col["node"].get_script() == m.criteria["type"]) and \
			(not m.criteria.has("id") or col["id"] == m.criteria["id"]):
				m.progress += 1
	if col["node"] is Creature and main.tutorial.step == 12:
		main.tutorial.next()
	collectibles.erase(col)
	col["node"].queue_free()
