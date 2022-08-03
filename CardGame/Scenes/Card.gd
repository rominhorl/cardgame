extends KinematicBody2D

var CardPosition
var MousePosition
var MouseHovering = false
var CardFollowingMouse = false
var speed = 600


func _physics_process(delta):
	
	MousePosition = get_viewport().get_mouse_position()
	CardPosition = position
	
	if MouseHovering and Input.is_action_just_pressed("LeftClick"):
		if CardFollowingMouse:
			CardFollowingMouse = false
		else:
			CardFollowingMouse = true

	
	if CardFollowingMouse == true:
		move_and_slide(((MousePosition - CardPosition)) * speed * delta)
		
	

func _on_CardArea_mouse_entered():
	MouseHovering = true
	
func _on_CardArea_mouse_exited():
	MouseHovering = false
	
