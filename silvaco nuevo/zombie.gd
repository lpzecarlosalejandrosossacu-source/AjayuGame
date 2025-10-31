extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@export var objetivo: NodePath          # Nodo del jugador
var jugador: Node = null

var velocidad = 50
var direccion = Vector2.ZERO
var tiempo_cambio = 0
var tiempo_limite = 2.0  # cambia dirección cada 2 segundos
@export var rango_ataque = 80.0         # distancia mínima para atacar

func _ready():
	cambiar_direccion()
	if objetivo:
		jugador = get_node(objetivo)

func _physics_process(delta):
	if jugador:
		var vector_al_jugador = jugador.global_position - global_position
		var distancia = vector_al_jugador.length()

		if distancia <= rango_ataque:
			# Atacar al jugador
			velocity = Vector2.ZERO
			if sprite.animation != "ataqueadelante":
				sprite.play("ataqueadelante")
			# Aquí podrías reducir la vida del jugador
		else:
			# Seguir al jugador
			direccion = vector_al_jugador.normalized()
			velocity = direccion * velocidad
			move_and_slide()
			actualizar_animacion(direccion)
	else:
		# Movimiento aleatorio
		tiempo_cambio += delta
		if tiempo_cambio > tiempo_limite:
			cambiar_direccion()
			tiempo_cambio = 0

		velocity = direccion * velocidad
		move_and_slide()
		actualizar_animacion(direccion)

func actualizar_animacion(dir: Vector2):
	if dir.y < 0:
		sprite.play("atras")
	elif dir.y > 0:
		sprite.play("frente")
	elif dir.x < 0:
		sprite.play("izquierda")
	elif dir.x > 0:
		sprite.play("derecha")

func cambiar_direccion():
	var direcciones = [
		Vector2(0, -1), # arriba
		Vector2(0, 1),  # abajo
		Vector2(-1, 0), # izquierda
		Vector2(1, 0)   # derecha
	]
	direccion = direcciones[randi() % direcciones.size()]
