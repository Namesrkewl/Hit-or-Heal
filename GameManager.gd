extends Node2D

# Assume these are your player and enemy nodes with scripts that manage health, attacks, etc.
@onready var game = $Game
@onready var player = $Game/Player
@onready var enemy = $Game/Enemy
@onready var ui = $Game/UILayer/UI
@onready var hitAmount = $Game/UILayer/UI/HitButton/HitText/HitAmount
@onready var healAmount = $Game/UILayer/UI/HealButton/HealText/HealAmount
@onready var gameOver = $GameOver
@onready var tutorial = $Tutorial
@onready var playerHealth = $Game/UILayer/PlayerUI/PlayerHealth
@onready var enemyHealth = $Game/UILayer/EnemyUI/EnemyHealth
@onready var actionValue = $Game/UILayer/EnemyUI/ActionValue
@onready var scoreText = $GameOver/GameOverMenu/ScoreText
@onready var selectSound = $SelectSound
@onready var scoreSound = $ScoreSound
@onready var gameOverSound = $GameOverSound

func _ready():
	# Initialize game, player, and enemy states if needed
	Restart()

func SetDefaultValues():
	player.maxHealth = 10
	player.health = 10
	player.hitPower = 10
	player.healPower = 5
	enemy.maxHealth = 5
	enemy.health = 5
	enemy.hitPower = 2
	enemy.healPower = 2
	ui.score.text = str(0)
	playerHealth.SetHealthText(player)
	enemyHealth.SetHealthText(enemy)
	hitAmount.SetHitAmount(player.hitPower)
	healAmount.SetHealAmount(player.healPower)

func _on_hit_button_pressed():
	selectSound.play()
	# Example function when hit button is pressed
	enemy.TakeDamage(player.hitPower)  # Assuming your player script has an 'attack' method that affects the enemy

func _on_heal_button_pressed():
	selectSound.play()
	# Example function when heal button is pressed
	player.Heal()  # Assuming your player script has a 'heal' method

func GameOver():
	gameOverSound.play()
	game.visible = false
	game.get_child(2).visible = false
	gameOver.visible = true
	scoreText.SetScoreText(ui.get_child(2).text)
	
	
func Restart():
	tutorial.visible = true
	game.visible = false
	gameOver.visible = false
	game.get_child(2).visible = false
	
	
func Start():
	tutorial.visible = false
	game.visible = true
	game.get_child(2).visible = true
	SetDefaultValues()
	enemy.DecideAction()


func _on_play_again_pressed():
	selectSound.play()
	Restart()


func _on_play_pressed():
	selectSound.play()
	Start()
