extends MarginContainer

var snake_description = [
	"A genus derived from anacondas from Earth, with a few distinctive characteristics. It diverged from Earth snakes in response to the starkly different foreign environments of the planets of TRAPPIST-2. It has swelled to multiple times the size of its ancestors because of resource abundance and a lack of predators that limited the growth of “normal” snakes. The defining physical features used to identify the genus are the plate of bright aquamarine scales along its underbelly and its size. Multiple variants exist on different planets in the TRAPPIST-2 star system, but the aforementioned characteristics are present among all of them. They are aggressive and territorial in nature because of competition with other magnacondas.",
	"It's suspected that the genus spread throughout TRAPPIST-2 after hitching a ride in the cargo compartment of a spacecraft during the early years of space exploration. Populations of the genus have been found on most planets in the star system. With no apparent natural predators in TRAPPIST-2, the genus has thrived and consequentially led the populations of native species that it predates to dwindle. Biodiversity on the planets have decreased noticeably following its introduction, which could make these ecosystems more susceptible to trophic cascades.",
	"Inspired by the introduction of Burmese pythons as an invasive species in Florida"
]

var bug_description = [
	"An abnormally large beetle, easily identified by their shiny ruby exoskeletons and distinctive blue wings. They lay their eggs in the crevices of large trees, which provide shelter and a source of nutrients once they hatch. After hatching, the larvae dig through the bark, feeding and developing inside the tree for a large majority of their lives.",
	"Flora in TRAPPIST have had little time to adapt to the sudden intrusion of the ruby reamer beetles, and as a result, tree populations have dwindled because of the beetles. The decrease in trees on every planet in the star system has led to harm to the atmosphere, soil, and multiple native species that rely on trees.",
	"Inspired by the introduction of emerald ash borers to North America"
]

var rabbit_description = [
	"Brought to TRAPPIST-2 after pet bunnies kept in spacecrafts escaped onto the planets centuries ago. They reproduced and populations spread rapidly. The rabbits adapted extremely quickly to the climates, developing a rich orange fur and tripling in size after only a few generations.",
	"Unbound by resource scarcity and predators, the titian rabbits developed ravenous appetites and began grazing voraciously on vegetation on the planets, threatening many native plant species. Through overgrazing, populations of titian rabbit have left habitats barren and lifeless. A small seed vault has been constructed in the spaceport to save endangered flora for research and preservation.",
	"Inspired by the introduction of European rabbits to several islands in Europe and the Pacific"
]

func _process(_delta: float) -> void:
	%SnakeText.text = "[b]Observations:[/b]\n\n" \
		+(snake_description[0] if Game.research_levels["snake"] >= 1 else "Obtain research level 1 to view") \
		+"\n\n[b]Impact on Environment[/b]\n\n" \
		+(snake_description[1] if Game.research_levels["snake"] >= 2 else "Obtain research level 2 to view") \
		+"\n\n[i]"+snake_description[2]+"[/i]"
	
	%BugText.text = "[b]Observations:[/b]\n\n" \
		+(bug_description[0] if Game.research_levels["bug"] >= 1 else "Obtain research level 1 to view") \
		+"\n\n[b]Impact on Environment[/b]\n\n" \
		+(bug_description[1] if Game.research_levels["bug"] >= 2 else "Obtain research level 2 to view") \
		+"\n\n[i]"+bug_description[2]+"[/i]"
	
	%RabbitText.text = "[b]Observations:[/b]\n\n" \
		+(rabbit_description[0] if Game.research_levels["rabbit"] >= 1 else "Obtain research level 1 to view") \
		+"\n\n[b]Impact on Environment[/b]\n\n" \
		+(rabbit_description[1] if Game.research_levels["rabbit"] >= 2 else "Obtain research level 2 to view") \
		+"\n\n[i]"+rabbit_description[2]+"[/i]"

func _on_snake_entry_focus_entered() -> void:
	%SnakeDescription.show()
	%BugDescription.hide()
	%RabbitDescription.hide()

func _on_bug_entry_focus_entered() -> void:
	%SnakeDescription.hide()
	%BugDescription.show()
	%RabbitDescription.hide()

func _on_rabbit_entry_focus_entered() -> void:
	%SnakeDescription.hide()
	%BugDescription.hide()
	%RabbitDescription.show()
