extends AnimatedSprite

# Velocidade de movimento: pixels/segundo
const SPEED = 500

# Velocidade de rotação: radianos/segundo
const ROT_SPEED = 1.5

var velocity = Vector2()
onready var target = position # onready executa quando o nodo está pronto (igual a colocar no _ready)
var rotation_dir = 0

# Usamos _input porque desejamos detectar um evento isolado (clique do mouse)
func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
		print(target)
		
func get_input() -> Vector2:
	var d := Vector2.ZERO
	
#	if Input.is_action_pressed("right"): d.x = 1
#	if Input.is_action_pressed("left"): d.x = -1
#	if Input.is_action_pressed("down"): d.y = 1
#	if Input.is_action_pressed("up"): d.y = -1

	# get_action_strength retorna 1, 0 ou -1 (para teclas)
	d.x = Input.get_action_strength("right")-Input.get_action_strength("left")
	d.y = Input.get_action_strength("down")-Input.get_action_strength("up")
	return d

func _physics_process(delta):
	
	# Várias estratégias de movimentação:
	# Descomente a linha desejada
	
	# Move nas 8 direções
	move8way(get_input().normalized(), delta)
	
	# Rotaciona com setas esq/dir, avança para frente/trás com setas up/down
#	rotAndMove(get_input(), delta)

	# Gira com o mouse e avança com as setas up/down
#	mouseTurn(get_input(), delta)

	# Movimento point and click com o mouse	
#	mouseMoveClick(delta)

# Move nas 8 direções
func move8way(input: Vector2, delta: float) -> void:
	# Deslocamento é essencialmente o vetor de entrada
	position += input * SPEED * delta
	
func rotAndMove(input: Vector2, delta: float) -> void:
	rotation_dir = input.x # setas right/left controlam ângulo de rotação
	# Zero graus consideramos como para a direita
	velocity = Vector2(-input.y, 0).rotated(rotation)
	position += velocity * SPEED * delta
	rotation += rotation_dir * ROT_SPEED * delta
	
func mouseTurn(input: Vector2, delta: float) -> void:
	# look_at gira o nodo para apontar para uma determinada posição
	look_at(get_global_mouse_position())
	velocity = Vector2(-input.y,0).rotated(rotation)
	position += velocity * SPEED * delta
	
func mouseMoveClick(delta: float) -> void:
	# Verificamos se estamos próximos o suficiente para evitar
	# que o sprite fique "tremendo" (jitter) - causado pelo deslocamento
	# ocorrer em função do delta (pode passar do target)
	if position.distance_to(target) > 5:
		# direction_to retorna um vetor do nodo ao alvo (basicamente, target-position)
		velocity = position.direction_to(target)
		position += velocity * SPEED * delta
	
	
