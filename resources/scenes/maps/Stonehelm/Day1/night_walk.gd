extends allMaps

@onready var natalie: NPCClass = $natalie


func destination_reacjed():
	await natalie.navigation_agent.navigation_finished
