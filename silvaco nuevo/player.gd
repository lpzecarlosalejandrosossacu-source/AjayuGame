extends CharacterBody2D

@export var speed := 150.0
@onready var anim := $AnimationPlayer

var estado := "quieto"
var direccion := "abajo"

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = input_vector * speed
	move_and_slide()

	if input_vector == Vector2.ZERO:
		estado = "quieto"
	else:
		estado = "caminar"
		if abs(input_vector.x) > abs(input_vector.y):
			direccion = "derecha" if input_vector.x > 0 else "izquierda"
		else:
			direccion = "abajo" if input_vector.y > 0 else "arriba"

	_actualizar_animacion()

func _actualizar_animacion():
	if anim == null:
		return

	var nombre_animacion = "%s_%s" % [estado, direccion]
	if anim.current_animation != nombre_animacion:
		anim.play(nombre_animacion)
