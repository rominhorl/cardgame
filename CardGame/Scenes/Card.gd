extends Control

var CardPosition
var MousePosition
var MouseHovering = false
var CardFollowingMouse = false

		
func _physics_process(delta):
	
	MousePosition = get_viewport().get_mouse_position()
	CardPosition = rect_position
	
	if MouseHovering and Input.is_action_just_pressed("LeftClick"):
		if CardFollowingMouse:
			CardFollowingMouse = false
		else:
			CardFollowingMouse = true

	
	if CardFollowingMouse == true:
		rect_position.x = MousePosition.x - 111
		rect_position.y = MousePosition.y - 162.5
		
	

func _on_CardArea_mouse_entered():
	MouseHovering = true
	
func _on_CardArea_mouse_exited():
	MouseHovering = false
	
