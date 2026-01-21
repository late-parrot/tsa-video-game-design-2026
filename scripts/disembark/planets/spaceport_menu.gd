extends Control

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

func _process(_delta: float) -> void:
	%Money.set_text(str(Game.money))
	
	if Input.is_action_just_pressed("left_bumper"):
		if %TabContainer.current_tab-1 < 0:
			%TabContainer.current_tab = %TabContainer.get_tab_count()-1
		else:
			%TabContainer.current_tab -= 1
		[%NetDistance, %SnakeResearch][%TabContainer.current_tab].grab_focus()
	elif Input.is_action_just_pressed("right_bumper"):
		if %TabContainer.current_tab+1 >= %TabContainer.get_tab_count():
			%TabContainer.current_tab = 0
		else:
			%TabContainer.current_tab += 1
		[%NetDistance, %SnakeResearch][%TabContainer.current_tab].grab_focus()
		
	for u in Game.upgrades:
		get_node(u["node"]).disabled = u["acquired"] or Game.money < u["cost"] or \
			u["required"] != -1 and not Game.upgrades[u["required"]]["acquired"]
		if u["acquired"]: get_node(u["node"]).text = "Acquired"

func _on_close_pressed() -> void:
	var main = get_node("../..")
	main.add_child(main.maneuver)
	main.maneuver.overlay.reset()
	queue_free()

func _on_net_distance_pressed() -> void:
	Game.upgrades[0]["acquired"] = true
	Game.money -= Game.upgrades[0]["cost"]
	Game.net_distance = 90

func _on_net_accuracy_pressed() -> void:
	Game.upgrades[1]["acquired"] = true
	Game.money -= Game.upgrades[1]["cost"]
	Game.net_accuracy = 1.5

func _on_max_energy_pressed() -> void:
	Game.upgrades[2]["acquired"] = true
	Game.money -= Game.upgrades[2]["cost"]
	Game.max_energy = 125

func _on_move_speed_pressed() -> void:
	Game.upgrades[3]["acquired"] = true
	Game.money -= Game.upgrades[3]["cost"]
	Game.move_speed = 1.5

func _on_reward_amount_pressed() -> void:
	Game.upgrades[4]["acquired"] = true
	Game.money -= Game.upgrades[4]["cost"]
	Game.reward_amount = 1.5
