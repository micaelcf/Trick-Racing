extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	visible = false
# Called when the node enters the scene tree for the first time.
func pause():
	get_tree().paused =  true
	visible = true

func _on_cont_but_pressed():
	get_tree().paused =  false
	visible = false

func _on_menu_but_pressed():
	visible = false
	get_tree().paused = false
	SceneChanger.change_scene("res://hud/initial_hud.tscn","fade")


func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused
		


func _on_music_but_toggled(button_pressed):
	var ms: AudioStreamPlayer = get_parent().get_node("music")
	ms.stream_paused = not button_pressed
	get_parent().music_on = button_pressed
	$music_but/Polygon2D.visible = not button_pressed
