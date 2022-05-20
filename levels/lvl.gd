extends Spatial


export (int) var laps_to_win = 3

var car :Spatial = null
var music_on = true
# Called when the node enters the scene tree for the first time.
func _ready():
	car = GameManager.cars_scenes[GameManager.i_car].instance()	# define o carro, de acordo com a seleção feita
	add_child(car)	# adiciona o carro na cena (árvore de nós) atual
	car.global_translate($Player.translation)	# posiciona o carro na posição do nó Player
	$Player.free()	# Retira o Player da cena
	car.is_show = false		# muda a propriedade do carro
	car.rotation_degrees = Vector3(0,90,0)		# rotaciona o carro para ficar reto na pista
	$Camera.set_target(car.get_node("CarMesh"))		# defina o alvo da câmera do nível
	$music.stream = GameManager.musics[GameManager.i_music]		# defina a faixa de audio da música
	$music.play()	# toca a música
	$game_hud/lap_num.bbcode_text = "[shake rate=4 level=15]"+str(GameManager.i_lap+1)+" / "+str(laps_to_win)
		

func _process(_delta):
	$game_hud/lap_time.bbcode_text = get_time_string()
	
	if not music_on:
		$music.stream_paused = true
# Acionado quando uma música acaba
func _on_music_finished():
	GameManager.i_music = (GameManager.i_music+1) % len(GameManager.musics)		# passa para a proxima musica
	$music.stream = GameManager.musics[GameManager.i_music]		# atualiza a faixa de áudio
	$music.play()	# toca a nova música

func get_path_direction(position):
	if $track/Path:
		var offset = $track/Path.curve.get_closest_offset(position)
		$track/Path/PathFollow.offset = offset
		return $track/Path/PathFollow.transform.basis.z

func get_time_string():
	var curr_time = car.get_node("timer").wait_time - car.get_node("timer").time_left
	var m = str(int(curr_time/60)) if int(curr_time/60) > 9 else "0"+str(int(curr_time/60))
	var s = str(int(curr_time)%60) if int(curr_time)%60 > 9 else "0"+str(int(curr_time)%60)
	var ms = str(int((curr_time - int(curr_time))*60)) if int((curr_time - int(curr_time))*60) > 9 else "0"+str(int((curr_time - int(curr_time))*60))
	return m+":"+s+":"+ms

func _on_Area_body_entered(body: Spatial):
	var is_car = body.get_parent().name.to_lower().count("car")>0
	var is_ai = body.get_parent().name.to_lower().count("ai")>0
	if is_car and not is_ai:
		var car_mesh : Spatial = body.get_parent().get_node("CarMesh")
		var v1 :Vector3= transform.basis.x
		var v2 :Vector3= car_mesh.global_transform.basis.z
		
		if v1.x * v2.x > 0:
			GameManager.i_lap += 1
			$game_hud/lap_num.bbcode_text = "[shake rate=4 level=15]"+str(GameManager.i_lap)+" / "+str(laps_to_win)
			$game_hud/last_lap.bbcode_text = "[shake rate=4 level=15]"+get_time_string()
			car.get_node("timer").start()
			if GameManager.i_lap > laps_to_win:
				$win_game.win()


func _on_lap_body_entered(body):
	var is_car = body.get_parent().name.to_lower().count("car")>0
	var is_ai = body.get_parent().name.to_lower().count("ai")>0
	if is_car and not is_ai:
		var car_mesh : Spatial = body.get_parent().get_node("CarMesh")
		var v1 :Vector3= transform.basis.x
		var v2 :Vector3= car_mesh.global_transform.basis.z
		
		if v1.x * v2.x > 0 and not car.speed_input < 0:
			GameManager.i_lap += 1
			if GameManager.i_lap >= laps_to_win:
				$win_game.win()
			$game_hud/lap_num.bbcode_text = "[shake rate=4 level=15]"+str(GameManager.i_lap)+" / "+str(laps_to_win)
			$game_hud/last_lap.bbcode_text = "[shake rate=4 level=15]"+get_time_string()
			car.get_node("timer").start()
			
