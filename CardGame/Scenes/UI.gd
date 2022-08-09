extends Control

signal TimeToDraw

# general variables
var isPlayerTurn = false
var turnCycle = 0
onready var turn = 1
var cardQnt = 0

# wait variables
onready var turnPhase = 'wait'

# draw variables
var cardsQntToDraw = 3
var firstQntDrawn = 6
var normalQntDrawn = 3
var cardsDrawn = 0
var drawTimer = 0
var drawInterval = 0.5

# play variables
var baseTime = 12
var minTime = 6
var decRate = 2
var skipPlay = false
var turnTimeNow = 0
var isTimerOn = false

# end variables
var maxNumberOfCards = 10

func _ready():
	$ColorRect.show()

func _process(delta):
	turnManager(delta)
	

func turnManager(delta):
	match turnPhase:
		"wait":
			# wait for player input to signal the game to start
			if Input.is_action_just_pressed("LeftClick"):
				turnPhase = 'draw'	
				$ColorRect.hide()
				
		"draw":
			# draw rules
			playMusic()
			draw_phase(delta)
			skipPlay = false
			
		"play":
			isPlayerTurn = true
			play_phase(delta)
			
		"end":
			isPlayerTurn = false
			skipPlay = false
			end_phase()
			

	
func draw_phase(delta):	
	if (turn >= 2):
		cardsQntToDraw = normalQntDrawn
	else:
		cardsQntToDraw = firstQntDrawn
		
	if (turnCycle == 0):
		print('setting draw phase')
		cardsDrawn = 0
		drawTimer = 0
	
	
	drawTimer += delta
	turnCycle += 1
	
	if (drawTimer >= drawInterval) and cardsDrawn < cardsQntToDraw:
		print('drawn a card')
		emit_signal("TimeToDraw")
		cardsDrawn += 1
		#cardQnt += 1
		drawTimer = 0
	
	elif cardsDrawn == cardsQntToDraw:
		print('ending draw phase')
		turnPhase = 'play'
		turnCycle = 0
	

func play_phase(delta):
	isTimerOn = true
	if (turn >= 2) and (turnCycle == 0):
		print('setting play phase for ', str(turn), 'turn')
		turnTimeNow = baseTime -decRate*(turn-1)
	elif (turn == 1) and (turnCycle == 0):
		print('setting play phase')
		turnTimeNow = baseTime

	if (turnCycle == 0) and (turnTimeNow < minTime):
		turnTimeNow = minTime

	$TimeLabel.text = "%02d" % [turnTimeNow]
	turnCycle += 1
	
	if isTimerOn:
		turnTimeNow -= delta	

	if (turnTimeNow <= 0) or skipPlay:
		print('end of play phase')
		isTimerOn = false
		$TimeLabel.text = ""
		turnPhase = 'end'
		turnCycle = 0
		print(turnCycle)
		




func end_phase():
	if cardQnt <= (maxNumberOfCards - normalQntDrawn):
		print('player wont overdraw, starting another round')
		turn += 1
		turnPhase = 'draw'
	if cardQnt > (maxNumberOfCards - normalQntDrawn):
		print('player will overdraw, player lost')
		get_tree().change_scene("res://Scenes/Main.tscn")
		# morreu
		pass
	pass

func playMusic():
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()





func updateCardHandSize(size):
	print('na mao tem' + str(size))
	cardQnt = size

func _on_Button_pressed():
	skipPlay = true
	print('pressed pass')
