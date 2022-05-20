extends Node


# Declare member variables here. Examples:
var cars_scenes := []
var musics = []
var power_ups = []
var i_car = 0
var i_music = 0
var i_track = 0
var music_paused = false
var i_lap = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#musics = get_resourcers_array("res://assets/music", "game",".wav")
	cars_scenes = get_resourcers_array("res://cars","Car",".tscn")
	power_ups = get_resourcers_array("res://powers/","power",".tscn")
	
	musics = [preload("res://assets/music/game0.wav"),preload("res://assets/music/game1.wav"),preload("res://assets/music/game2.wav"),preload("res://assets/music/game3.wav")]
		
	
	
	print("loaded resourcers")
	print("cars_scenes: ", cars_scenes)
	print("musics: ", musics)
	print("power_ups: ", power_ups)
	

func get_resourcers_array(main_path, begin_with, ends_with):
	var directory = Directory.new()
	var error = directory.open(main_path)
	var out = []
	if error == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while (file_name != ""):
			if file_name.begins_with(begin_with) and file_name.ends_with(ends_with):
				var res = main_path+"/"+file_name
				print(res)
				out.append(load(res))
			file_name = directory.get_next()
	else:
		print("Error opening directory")
	directory.list_dir_end()
	
	return out
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
