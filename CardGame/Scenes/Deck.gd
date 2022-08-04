extends Control

var MouseHovering = false
const Card = preload("res://Scenes/Card.tscn")
const CardList = preload("res://CardDatabase.gd")


func _physics_process(delta):
	
	if MouseHovering and Input.is_action_just_pressed("LeftClick"):
		draw_a_card(1)
#		
		
		
func _on_DeckArea_mouse_entered():
	MouseHovering = true


func _on_DeckArea_mouse_exited():
	MouseHovering = false


func draw_a_card(quantity):
	var CardRandom = randi()%5
	var AuxiliaryList = CardList.CardList.keys()
	var WhichCard = CardList.CardList.get(AuxiliaryList[CardRandom])
	print(WhichCard)
	var NewCard = Card.instance()
	NewCard.get_node("FrontBg").texture = load(str("res://card shapes/",WhichCard.get("Biome"),".png"))
	NewCard.get_node("Type").texture = load(str("res://Assets/type icons/",WhichCard.get("Type"),".png"))
#	NewCard.get_node("Type").scale = 0.5
	NewCard.position = Vector2(get_viewport().size.x/2,get_viewport().size.y/2)
	$Hand.add_child(NewCard)
	
