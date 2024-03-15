extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func SetHealthText(enemy):
	text = str(enemy.health) + "/" + str(enemy.maxHealth)
