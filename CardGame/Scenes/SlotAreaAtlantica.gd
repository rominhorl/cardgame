extends Area2D

var CardList = []
var CardMatch = false
var MouseHovering = false
var DeltaVar
var CardSpeedMove = 600

func _physics_process(delta):
	DeltaVar = delta
	OrganizeSlot(CardList, DeltaVar)

func CardPlaced(name):
	connect("PositionValid",get_parent().get_node("Deck&Hand/Hand").get_node(name),"PositionValid")
	if MouseHovering == true and get_parent().get_node("Deck&Hand/Hand").get_node(name).get_node("Biome").text == "Mata Atlântica":
		IsCardRelationValid(name)
		if CardMatch == true:
			CardList.append(name)
#			get_parent().get_node("Deck&Hand/Hand").get_node(name).position = position + Vector2(0+100*CardList.size(),0)
			get_parent().get_node("Deck&Hand/Hand").get_node(name).z_index = CardList.size()
			emit_signal("PositionValid")
			emit_signal("CountPointsAtlantica", CardList.size())
			playPlaceSound($PlacedSoundM)
			CardMatch = false

signal PositionValid
signal CountPointsAtlantica(Points)

func OrganizeSlot(CardList, delta):	
	if CardList.size() > 0:
		get_parent().get_node("Deck&Hand/Hand").get_node(CardList[-1]).move_and_slide((get_node("Slot0").position-get_parent().get_node("Deck&Hand/Hand").get_node(CardList[-1]).position)*delta*CardSpeedMove)
	if CardList.size() > 1:
		get_parent().get_node("Deck&Hand/Hand").get_node(CardList[-2]).move_and_slide((get_node("Slot1").position-get_parent().get_node("Deck&Hand/Hand").get_node(CardList[-2]).position)*delta*CardSpeedMove)
	if CardList.size() > 2:	
		get_parent().get_node("Deck&Hand/Hand").get_node(CardList[-3]).move_and_slide((get_node("Slot2").position-get_parent().get_node("Deck&Hand/Hand").get_node(CardList[-3]).position)*delta*CardSpeedMove)
	if CardList.size() > 3:
		get_parent().get_node("Deck&Hand/Hand").get_node(CardList[-4]).move_and_slide((get_node("Slot3").position-get_parent().get_node("Deck&Hand/Hand").get_node(CardList[-4]).position)*delta*CardSpeedMove)

func IsCardRelationValid(name):
	if CardList.size() > 0:
		if get_parent().get_node("Deck&Hand/Hand").get_node(CardList[CardList.size()-1]).get_node("TypeText").text == "Produtor" and get_parent().get_node("Deck&Hand/Hand").get_node(name).get_node("TypeText").text == "Consumidor1":
			CardMatch = true
		elif get_parent().get_node("Deck&Hand/Hand").get_node(CardList[CardList.size()-1]).get_node("TypeText").text == "Consumidor1" and get_parent().get_node("Deck&Hand/Hand").get_node(name).get_node("TypeText").text == "Consumidor2":
			CardMatch = true
		elif get_parent().get_node("Deck&Hand/Hand").get_node(CardList[CardList.size()-1]).get_node("TypeText").text == "Consumidor2" and get_parent().get_node("Deck&Hand/Hand").get_node(name).get_node("TypeText").text == "Decompositor":
			CardMatch = true
		elif get_parent().get_node("Deck&Hand/Hand").get_node(CardList[CardList.size()-1]).get_node("TypeText").text == "Decompositor" and get_parent().get_node("Deck&Hand/Hand").get_node(name).get_node("TypeText").text == "Produtor":
			CardMatch = true
	else:
		CardMatch = true

func playPlaceSound(soundNode):
	randomize()
	soundNode.pitch_scale = rand_range(0.8,1.2)
	soundNode.play()

func _on_SlotAreaCaatinga_mouse_entered():
	MouseHovering = true


func _on_SlotAreaCaatinga_mouse_exited():
	MouseHovering = false
