extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var car : Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(1*delta)


func _on_Area_body_entered(body: Spatial):
	var is_car = body.get_parent().name.to_lower().count("car")>0
	var is_ai = body.get_parent().name.to_lower().count("ai")>0
	if is_car and not is_ai:
#		print("Colide with car")
		car = body.get_parent()
#		print(car)
		car.get_node("animation").play("increase")
		visible = false
		$buff_timer.start()
		car.get_parent().get_node("power_pick_sfx").play()
	
func _on_buff_timer_timeout():
	visible = true
	car.get_node("animation").play("decrease")
