extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var launch_speed = 3000
var attacking = false
var original_pos : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ball.sleeping = true
	print(translation)
	original_pos = translation
	pass # Replace with function body.


func _on_Area_body_entered(body: Node):
	var is_car = body.get_parent().name.to_lower().count("car")>0
	var is_ai = body.get_parent().name.to_lower().count("ai")>0
	if attacking and is_car:
		if not body.get_parent().invencible:
			get_parent().get_parent().get_node("music").stop()
			SceneChanger.game_over()
	elif attacking and is_ai:
		body.get_parent().get_parent().remove_child(body.get_parent())
	elif is_car and not attacking:
		var car_mesh = body.get_parent().get_node("CarMesh")
		$Ball.add_collision_exception_with(body)
		$Ball.add_central_force(car_mesh.global_transform.basis.z * launch_speed)
		$Timer.start()
		$anim.play("end")
		attacking = true
		body.get_parent().get_parent().get_node("power_pick_sfx").play()
		
		
		

func _on_Timer_timeout():
#	var level = get_parent().get_parent()
	var bomb = get_parent()
#	print("Acabou o tempo da bomba")
	var new_bomb : Spatial= GameManager.power_ups[0].instance()
	bomb.add_child(new_bomb)
#	new_bomb.global_translate(original_pos)
	get_parent().remove_child(self)
	
	
	
