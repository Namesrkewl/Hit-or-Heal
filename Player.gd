extends CharacterBody2D

var health: int
var maxHealth: int
var hitPower: int
var healPower: int
@onready var gameManager = get_tree().root.get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func Hit(target):
	target.TakeDamage(hitPower)

func Heal():
	health += healPower
	if health > maxHealth:
		health = maxHealth
	gameManager.playerHealth.SetHealthText(self)
	get_tree().root.get_child(0).enemy.Enrage()
	get_tree().root.get_child(0).enemy.Act()
	

func TakeDamage(damage):
	health -= damage
	if health <= 0:
		health = 0
		Die()
	gameManager.playerHealth.SetHealthText(self)
	
func Die():
	gameManager.GameOver()
	pass
	
func LevelUp(level):
	var healthIncrease = (10 + (level * 5)) - maxHealth
	maxHealth = (10 + (level * 5))
	health += healthIncrease
	hitPower = 10 + level
	healPower = 5 + (level / 2)
	gameManager.playerHealth.SetHealthText(self)
	gameManager.hitAmount.SetHitAmount(hitPower)
	gameManager.healAmount.SetHealAmount(healPower)
	
