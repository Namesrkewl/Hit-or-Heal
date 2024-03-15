extends Control

@onready var score = $Score
@onready var gameManager = get_tree().root.get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	ResetScore()

func ResetScore():
	score.text = str(0)

func IncreaseScore():
	gameManager.scoreSound.play()
	var level = int(score.text) + 1
	score.text = str(level)
	get_tree().root.get_child(0).player.LevelUp(level)
	get_tree().root.get_child(0).enemy.NextEnemy(level)
