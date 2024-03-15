extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func SetHealthText(player):
	text = str(player.health) + "/" + str(player.maxHealth)
