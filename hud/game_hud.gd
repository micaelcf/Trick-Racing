extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == "lvl2":
		$lap_num.set("custom_colors/default_color",Color.lightgray)
		$lap_time.set("custom_colors/default_color",Color.lightgray)
		$last_lap.set("custom_colors/default_color",Color.lightgray)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
