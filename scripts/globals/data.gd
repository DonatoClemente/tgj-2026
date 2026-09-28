extends Node

#signal finished

signal died

# Defines if this is the first time the main menu has loaded this runtime
var first_load = true

func player_dead():
	died.emit()

## Saves data variables to file
#func save():
	#finished.emit()
#
## Loades data variables from file
#func load_vars():
	#pass
