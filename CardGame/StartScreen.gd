extends Node

func _process(delta):
	Transition()

func Transition():
	$AnimationPlayer.play("FadeOut")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Menu.tscn")
