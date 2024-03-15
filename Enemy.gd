extends CharacterBody2D

var health: int
var maxHealth: int
var hitPower: int
var healPower: int
var actionMode: bool
var rng = RandomNumberGenerator.new()
@onready var actionSprite = $ActionSprite
@onready var gameManager = get_tree().root.get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func Heal():
	health += healPower
	if health > maxHealth:
		health = maxHealth
	gameManager.enemyHealth.SetHealthText(self)

func TakeDamage(damage):
	health -= damage
	if health <= 0:
		health = 0
		Die()
	else:
		Act()
	gameManager.enemyHealth.SetHealthText(self)

func Die():
	get_tree().root.get_child(0).ui.IncreaseScore()
	pass
	
func NextEnemy(level):
	maxHealth = (maxHealth + 1) * 1.2
	health = maxHealth
	hitPower = 2 + (level / 2)
	healPower = 2 + (level / 4)
	gameManager.enemyHealth.SetHealthText(self)
	DecideAction()
	
func Enrage():
	hitPower *= 1.3
	
func DecideAction():
	rng.randomize()
	if rng.randi_range(0, 1) == 0:
		actionMode = true
		gameManager.actionValue.SetActionValue(hitPower)
	else:
		actionMode = false
		gameManager.actionValue.SetActionValue(healPower)
	actionSprite.SetActionSprite(actionMode)

func Act():
	if actionMode == true:
		get_tree().root.get_child(0).player.TakeDamage(hitPower)
	else:
		Heal()
	DecideAction()
