extends Control

@onready var main = $"../.."

func _ready() -> void:
	if Game.upgrades == null:
		Game.upgrades = [
			{
				"node": "%NetDistance",
				"cost": 10,
				"acquired": false,
				"required": -1
			},
			{
				"node": "%NetAccuracy",
				"cost": 15,
				"acquired": false,
				"required": 0
			},
			{
				"node": "%MaxEnergy",
				"cost": 10,
				"acquired": false,
				"required": -1
			},
			{
				"node": "%MoveSpeed",
				"cost": 15,
				"acquired": false,
				"required": 2
			},
			{
				"node": "%RewardAmount",
				"cost": 10,
				"acquired": false,
				"required": -1
			}
		]
	main.tutorial.connect("step_finished", _on_tutorial_step_finished)

func update_research(id: String) -> void:
	var level = get_node("%"+id.capitalize()+"Level")
	var reward = get_node("%"+id.capitalize()+"Reward")
	var research = get_node("%"+id.capitalize()+"Research")
	var progress = get_node("%"+id.capitalize()+"Progress")
	var lvl = Game.research_levels[id]
	
	level.text = "Max level" if lvl>=Game.max_research else "Level "+str(lvl) \
		if Game.research_levels[id] else "No research"
	if lvl<Game.max_research:
		reward.text = str(Game.research_rewards[lvl])
		research.get_node("Label").text = str(Game.research_reqs[lvl]) \
			+" required ("+(str(Game.ship_cargo[id]) if Game.ship_cargo.has(id) else "0")+" in inventory)"
		var time = Game.research_times[id]
		research.get_node("Button").disabled = time!=0 or lvl>=Game.max_research or \
			Game.ship_cargo[id]<Game.research_reqs[lvl] if Game.ship_cargo.has(id) else true
		progress.get_node("Label").text = "In progress: %d:%02d left" % [int(time/60), int(time)%60]
		progress.get_node("ProgressBar").value = 10-time
		research.get_node("Label").visible = time==0
		progress.visible = time!=0
	else:
		research.get_node("Label").visible = false
		progress.visible = false
		reward.get_parent().get_parent().visible = false

func _process(_delta: float) -> void:
	%Money.set_text(str(Game.money))
	
	if Input.is_action_just_pressed("left_bumper"):
		if %TabContainer.current_tab-1 < 0:
			%TabContainer.current_tab = %TabContainer.get_tab_count()-1
		else:
			%TabContainer.current_tab -= 1
	elif Input.is_action_just_pressed("right_bumper"):
		if %TabContainer.current_tab+1 >= %TabContainer.get_tab_count():
			%TabContainer.current_tab = 0
		else:
			%TabContainer.current_tab += 1
		
	for u in Game.upgrades:
		get_node(u["node"]).disabled = u["acquired"] or Game.money < u["cost"] or \
			u["required"] != -1 and not Game.upgrades[u["required"]]["acquired"]
		if u["acquired"]: get_node(u["node"]).text = "Acquired"
	
	update_research("snake")
	update_research("bug")
	update_research("rabbit")
	
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

func _on_tab_container_tab_changed(tab: int) -> void:
	if tab == 3: return
	[
		%NetDistance, %SnakeResearch/Button,
		%Journal.get_node("%SnakeEntry"), null
	][tab].grab_focus()

func _on_close_pressed() -> void:
	Game.scene_transition.transition()
	await Game.scene_transition.change_scene
	main.add_child(main.maneuver)
	main.maneuver.overlay.reset()
	queue_free()

func _on_net_distance_pressed() -> void:
	Game.upgrades[0]["acquired"] = true
	Game.money -= Game.upgrades[0]["cost"]
	Game.net_distance = 90
	Game.total_upgrades += 1
	for m in Game.missions:
		if m.type == Mission.MissionType.UPGRADE:
			m.progress += 1

func _on_net_accuracy_pressed() -> void:
	Game.upgrades[1]["acquired"] = true
	Game.money -= Game.upgrades[1]["cost"]
	Game.net_accuracy = 1.5
	Game.total_upgrades += 1
	for m in Game.missions:
		if m.type == Mission.MissionType.UPGRADE:
			m.progress += 1

func _on_max_energy_pressed() -> void:
	Game.upgrades[2]["acquired"] = true
	Game.money -= Game.upgrades[2]["cost"]
	Game.max_energy = 125
	Game.total_upgrades += 1
	for m in Game.missions:
		if m.type == Mission.MissionType.UPGRADE:
			m.progress += 1

func _on_move_speed_pressed() -> void:
	Game.upgrades[3]["acquired"] = true
	Game.money -= Game.upgrades[3]["cost"]
	Game.move_speed = 1.5
	Game.total_upgrades += 1
	for m in Game.missions:
		if m.type == Mission.MissionType.UPGRADE:
			m.progress += 1

func _on_reward_amount_pressed() -> void:
	Game.upgrades[4]["acquired"] = true
	Game.money -= Game.upgrades[4]["cost"]
	Game.reward_amount = 1.5
	Game.total_upgrades += 1
	for m in Game.missions:
		if m.type == Mission.MissionType.UPGRADE:
			m.progress += 1


func _on_snake_research_button_pressed() -> void:
	Game.research_times["snake"] = 10
	Game.ship_cargo["snake"] -= Game.research_reqs[Game.research_levels["snake"]]
	for m in Game.missions:
		if m.type == Mission.MissionType.RESEARCH:
			m.progress += 1

func _on_bug_research_button_pressed() -> void:
	Game.research_times["bug"] = 10
	Game.ship_cargo["bug"] -= Game.research_reqs[Game.research_levels["bug"]]
	for m in Game.missions:
		if m.type == Mission.MissionType.RESEARCH:
			m.progress += 1
	
func _on_rabbit_research_button_pressed() -> void:
	Game.research_times["rabbit"] = 10
	Game.ship_cargo["rabbit"] -= Game.research_reqs[Game.research_levels["rabbit"]]
	for m in Game.missions:
		if m.type == Mission.MissionType.RESEARCH:
			m.progress += 1


func _on_tutorial_step_finished(step):
	if step == 19 or step == 20 or step == 21:
		%TabContainer.current_tab += 1
