extends Area2D

var CardList = []
var CardMatch = false
var MouseHovering = false

func CardPlaced(name):
	connect("PositionValid",get_parent().get_node("Deck&Hand/Hand").get_node(name),"PositionValid")
	if MouseHovering == true and get_parent().get_node("Deck&Hand/Hand").get_node(name).get_node("Biome").text == "Caatinga":
		IsCardRelationValid(name)
		if CardMatch == true:
			CardList.append(name)
			get_parent().get_node("Deck&Hand/Hand").get_node(name).position = position + Vector2(0,50*CardList.size())
			get_parent().get_node("Deck&Hand/Hand").get_node(name).z_index = CardList.size()
			emit_signal("PositionValid")
			CardMatch = false



signal PositionValid

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

func _on_SlotAreaCaatinga_mouse_entered():
	MouseHovering = true


func _on_SlotAreaCaatinga_mouse_exited():
	MouseHovering = false
