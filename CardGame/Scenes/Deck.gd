extends Control

var MouseHovering = false
const Card = preload("res://Scenes/Card.tscn")
const CardList = preload("res://CardDatabase.gd")
onready var MidScreen = Vector2(get_viewport().size.x/2,get_viewport().size.y/2)
var HandPoints
var CardsHand = []
var CardNamer = 0

func _ready():
	HandPoints = draw_circle_arc(MidScreen+Vector2(0,MidScreen.y), get_viewport().size.x*0.4, get_viewport().size.y*0.15, -90, 90, Color(0.0, 1.0, 0.0))

func _process(delta):
	
	if MouseHovering and Input.is_action_just_pressed("LeftClick"):
		draw_a_card()
	
#		
		
		
func _on_DeckArea_mouse_entered():
	MouseHovering = true


func _on_DeckArea_mouse_exited():
	MouseHovering = false


func draw_a_card():
	CardNamer += 1
	var CardRandom = randi()%CardList.CardList.size()
	var AuxiliaryList = CardList.CardList.keys()
	var WhichCard = CardList.CardList.get(AuxiliaryList[CardRandom])
	print(WhichCard)
	var NewCard = Card.instance()
	NewCard.get_node("FrontBg").texture = load(str("res://card shapes/",WhichCard.get("Biome"),".png"))
	NewCard.get_node("Type").texture = load(str("res://Assets/type icons/",WhichCard.get("Type"),".png"))
	NewCard.get_node("Name").text = WhichCard.get("Name")
	NewCard.get_node("Biome").text = WhichCard.get("Biome")
	NewCard.name = str("Card",CardNamer)
	CardsHand.append(NewCard.name)
	$Hand.add_child(NewCard)
	OrganizeHand()
	print(CardsHand)
	
#~~~~~~~~~~~~~~~~~~~~~~Organizar a mão~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

func OrganizeHand():
	match CardsHand.size():
		1:
			$Hand.get_node(str(CardsHand[0])).position = HandPoints[50]
			continue
		2:
			$Hand.get_node(str(CardsHand[0])).position = HandPoints[45]
			$Hand.get_node(str(CardsHand[0])).rotation = -0.1
			$Hand.get_node(str(CardsHand[1])).position = HandPoints[55]
			$Hand.get_node(str(CardsHand[1])).rotation = 0.1
			continue
		3:
			$Hand.get_node(str(CardsHand[0])).position = HandPoints[40]
			$Hand.get_node(str(CardsHand[0])).rotation = -0.1
			$Hand.get_node(str(CardsHand[1])).position = HandPoints[50]
			$Hand.get_node(str(CardsHand[1])).rotation = 0
			$Hand.get_node(str(CardsHand[2])).position = HandPoints[60]
			$Hand.get_node(str(CardsHand[2])).rotation = 0.1
			continue
		4:
			$Hand.get_node(str(CardsHand[0])).position = HandPoints[35]
			$Hand.get_node(str(CardsHand[0])).rotation = -0.15
			$Hand.get_node(str(CardsHand[1])).position = HandPoints[45]
			$Hand.get_node(str(CardsHand[1])).rotation = -0.1
			$Hand.get_node(str(CardsHand[2])).position = HandPoints[55]
			$Hand.get_node(str(CardsHand[2])).rotation = 0.1
			$Hand.get_node(str(CardsHand[3])).position = HandPoints[65]
			$Hand.get_node(str(CardsHand[3])).rotation = 0.15
			continue
	
#~~~~~~~~~~~~~~~~~~~~~Função para plotar a elipse~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

func draw_circle_arc(center, radius1, radius2, angle_from, angle_to, color):
	var nb_points = 100
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point)*radius1, sin(angle_point)*radius2))
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
	return points_arc
