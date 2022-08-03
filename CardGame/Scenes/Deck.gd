extends Control

var MouseHovering = false
const Card = preload("res://Scenes/Card.tscn")


func _physics_process(delta):
	
	if MouseHovering and Input.is_action_just_pressed("LeftClick"):
		var NewCard = Card.instance()
		NewCard.position = Vector2(get_viewport().size.x/2,get_viewport().size.y/2)
		$Hand.add_child(NewCard)
		print("clicou")
		
		
func _on_DeckArea_mouse_entered():
	MouseHovering = true
	print("entrou")


func _on_DeckArea_mouse_exited():
	MouseHovering = false
	print("saiu")
