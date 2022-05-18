extends Control
#

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tracks = $view_track/Viewport/levels.get_children()
var cars = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in GameManager.cars_scenes:
		var c = i.instance()
		c.is_show = true
		c.visible = false
		$view_car/Viewport/cars.add_child(c)
	cars = get_node("view_car/Viewport/cars").get_children()



var aux = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var prev_car = GameManager.i_car
	if Input.is_action_just_pressed("steer_left"):
		GameManager.i_car = (GameManager.i_car - 1) % len(cars)
	if Input.is_action_just_pressed("steer_right"):
		GameManager.i_car = (GameManager.i_car + 1) % len(cars)

	cars[prev_car].visible = false
	cars[GameManager.i_car].visible = true

	$view_track/Viewport/levels.rotate_y(1*delta)
	
	var prev_track = GameManager.i_track
	if Input.is_action_just_pressed("accelerate"):
		GameManager.i_track = (GameManager.i_track - 1) % len(tracks)
	if Input.is_action_just_pressed("brake"):
		GameManager.i_track = (GameManager.i_track + 1) % len(tracks)
	
	tracks[prev_track].visible = false
	tracks[GameManager.i_track].visible = true
	
	$car_change.rect_rotation += 30*delta
	$track_change.rect_rotation += 30*delta
	
	#print("Current car:", GameManager.i_car)
	#print("Current level:", GameManager.i_track)
	pass


func _on_car_change_pressed():
	var prev_car = GameManager.i_car
	GameManager.i_car = (GameManager.i_car + 1) % len(cars)
	cars[prev_car].visible = false
	cars[GameManager.i_car].visible = true
	print("Current car:", GameManager.i_car)
	print("Current level:", GameManager.i_track)
	


func _on_track_change_pressed():
	var prev_track = GameManager.i_track
	GameManager.i_track = (GameManager.i_track + 1) % len(tracks)
	tracks[prev_track].visible = false
	tracks[GameManager.i_track].visible = true

func _on_play_butt_pressed():
	SceneChanger.change_scene("res://levels/lvl"+str(GameManager.i_track+1)+".tscn", "fade")
