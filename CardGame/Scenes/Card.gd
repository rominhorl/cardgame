extends KinematicBody2D

var CardPosition
var MousePosition
var MouseHovering = false
var CardFollowingMouse = false
var speed = 600
var CardPositionOnHand

func _physics_process(delta):
	
	MousePosition = get_viewport().get_mouse_position()
	CardPosition = position
	
	if MouseHovering and Input.is_action_just_pressed("LeftClick") and IsOnTop():
		CardFollowingMouse = true
		CardPositionOnHand = get_parent().get_parent().CardsHand.find(name)
		get_parent().get_parent().CardsHand.remove(CardPositionOnHand)
	if CardFollowingMouse == true and Input.is_action_just_released("LeftClick"):	
		CardFollowingMouse = false
		get_parent().get_parent().CardsHand.insert(CardPositionOnHand,name)
		

	
	if CardFollowingMouse == true:
		move_and_slide(((MousePosition - CardPosition)) * speed * delta)
		rotation = 0
		

func IsOnTop():
	for i in get_tree().get_nodes_in_group("Hovered"):
		if i.get_index() > get_index():
			return false
	return true

func _on_CardArea_mouse_entered():
	add_to_group("Hovered")
	MouseHovering = true
	
func _on_CardArea_mouse_exited():
	remove_from_group("Hovered")
	MouseHovering = false

