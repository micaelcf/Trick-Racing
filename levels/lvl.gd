extends Spatial


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

func _process(delta):
	if not music_on:
		$music.stream_paused = true
# Acionado quando uma música acaba
func _on_music_finished():
	GameManager.i_music = (GameManager.i_music+1) % len(GameManager.musics)		# passa para a proxima musica
	$music.stream = GameManager.musics[GameManager.i_music]		# atualiza a faixa de áudio
	$music.play()	# toca a nova música
