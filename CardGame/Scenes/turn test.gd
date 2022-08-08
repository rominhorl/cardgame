extends Node



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
var baseTime = 24
var decRate = 3
var skipPlay = false
var turnTimeNow = 0
var isTimerOn = false

func _process(delta):
	turnManager(delta)
	

func turnManager(delta):
	match turnPhase:
		"wait":
			# wait for player input to signal the game to start
			if Input.is_action_just_pressed("LeftClick"):
				turnPhase = 'draw'	
				
		"draw":
			# draw rules
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
		cardsDrawn += 1
		cardQnt += 1
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
	
	$VBoxContainer/timer.text = "%02d" % [turnTimeNow]
	turnCycle += 1
	
	if isTimerOn:
		turnTimeNow -= delta	

	if (turnTimeNow <= 0) or skipPlay:
		print('end of play phase')
		isTimerOn = false
		$VBoxContainer/timer.text = ""
		turnPhase = 'end'
		turnCycle = 0
		print(turnCycle)
		




func end_phase():
	if cardQnt <= 7:
		print('player wont overdraw, starting another round')
		turn += 1
		turnPhase = 'draw'
	if cardQnt > 7:
		print('player will overdraw, end game')
		# morreu
		pass
	pass

func count_points():
	pass


func _on_Button_pressed():
	skipPlay = true
	print('pressed pass')
