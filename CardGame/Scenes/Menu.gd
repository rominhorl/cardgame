extends Control

func _ready():
	pass 


func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_Play3_pressed():
	get_tree().quit()


func _on_HowToPlaybtn_pressed():
	$HowToPlay.visible = true
	$HowToPlay/Play2.disabled = false
	$HowToPlay/BackMenu.disabled = false


func _on_Play2_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_BackMenu_pressed():
	$HowToPlay.visible = false
	$HowToPlay/Play2.disabled = true
	$HowToPlay/BackMenu.disabled = true
