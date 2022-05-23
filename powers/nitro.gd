extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var car : Spatial
var save_acceleration = 0
var save_turn_speed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	rotate_y(delta)


func _on_Area_body_entered(body):
	var is_car = body.get_parent().name.to_lower().count("car")>0
	var is_ai = body.get_parent().name.to_lower().count("ai")>0
	if is_car:
		visible = false
		$Area.monitoring = false
		car = body.get_parent()
		save_acceleration = car.acceleration 
		save_turn_speed = car.turn_speed
#		print(car.acceleration, "   ", car.turn_speed)
		car.acceleration += 20
		car.turn_speed += 2
		$nitro_timer.start()
		car.get_parent().get_node("power_pick_sfx").play()
		


func _on_nitro_timer_timeout():
	visible = true
	$Area.monitoring = true
	car.acceleration -= 20
	car.turn_speed -= 2
#	print(car.acceleration, "   ", car.turn_speed)
