extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var AnimationP = get_node("AnimationPlayer")
var scene: String

func _ready():
	visible = false
	pass

func change_scene(new_scene, a):
	visible = true
	scene = new_scene
	AnimationP.play(a)

func play_scene():
	get_tree().change_scene(scene)

