extends MarginContainer

var snake_description = [
	"A genus derived from anacondas from Earth, with a few distinctive characteristics. It diverged from Earth snakes in response to the starkly different foreign environments of the planets of TRAPPIST-2. It has swelled to multiple times the size of its ancestors because of resource abundance and a lack of predators that limited the growth of “normal” snakes. The defining physical features used to identify the genus are the plate of bright aquamarine scales along its underbelly and its size. Multiple variants exist on different planets in the TRAPPIST-2 star system, but the aforementioned characteristics are present among all of them. They are extremely aggressive and territorial in nature because of competition with other [genus name].",
	"It's suspected that the genus spread throughout TRAPPIST-2 after hitching a ride in the cargo compartment of a spacecraft during the early years of space exploration. Populations of the genus have been found on most planets in the star system. With no apparent natural predators in TRAPPIST-2, the genus has thrived and consequentially led the populations of native species that it predates to dwindle. Biodiversity on [planet 1] and [planet 2] have decreased noticeably following its introduction, which could make these ecosystems more susceptible to trophic cascades.",
	"Inspired by the introduction of Burmese pythons as an invasive species in Florida"
]

var bug_description = [
	"A genus derived from anacondas from Earth, with a few distinctive characteristics. It diverged from Earth snakes in response to the starkly different foreign environments of the planets of TRAPPIST-2. It has swelled to multiple times the size of its ancestors because of resource abundance and a lack of predators that limited the growth of “normal” snakes. The defining physical features used to identify the genus are the plate of bright aquamarine scales along its underbelly and its size. Multiple variants exist on different planets in the TRAPPIST-2 star system, but the aforementioned characteristics are present among all of them. They are extremely aggressive and territorial in nature because of competition with other [genus name].",
	"It's suspected that the genus spread throughout TRAPPIST-2 after hitching a ride in the cargo compartment of a spacecraft during the early years of space exploration. Populations of the genus have been found on most planets in the star system. With no apparent natural predators in TRAPPIST-2, the genus has thrived and consequentially led the populations of native species that it predates to dwindle. Biodiversity on [planet 1] and [planet 2] have decreased noticeably following its introduction, which could make these ecosystems more susceptible to trophic cascades.",
	"Inspired by the introduction of Burmese pythons as an invasive species in Florida"
]

var rabbit_description = [
	"A genus derived from anacondas from Earth, with a few distinctive characteristics. It diverged from Earth snakes in response to the starkly different foreign environments of the planets of TRAPPIST-2. It has swelled to multiple times the size of its ancestors because of resource abundance and a lack of predators that limited the growth of “normal” snakes. The defining physical features used to identify the genus are the plate of bright aquamarine scales along its underbelly and its size. Multiple variants exist on different planets in the TRAPPIST-2 star system, but the aforementioned characteristics are present among all of them. They are extremely aggressive and territorial in nature because of competition with other [genus name].",
	"It's suspected that the genus spread throughout TRAPPIST-2 after hitching a ride in the cargo compartment of a spacecraft during the early years of space exploration. Populations of the genus have been found on most planets in the star system. With no apparent natural predators in TRAPPIST-2, the genus has thrived and consequentially led the populations of native species that it predates to dwindle. Biodiversity on [planet 1] and [planet 2] have decreased noticeably following its introduction, which could make these ecosystems more susceptible to trophic cascades.",
	"Inspired by the introduction of Burmese pythons as an invasive species in Florida"
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
