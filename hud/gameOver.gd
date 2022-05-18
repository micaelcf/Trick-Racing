extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func game_over():
#	visible = true
	$an.play("over")
	get_tree().paused = true
	

func go_menu():
	get_tree().change_scene("res://hud/initial_hud.tscn")
	get_tree().paused = false
