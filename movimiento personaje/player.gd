extends CharacterBody3D

# Velocidades
const WALK_SPEED = 20.0
const RUN_SPEED = 30.0
const JUMP_VELOCITY = 6

# Variable para guardar la velocidad actual
var current_speed = WALK_SPEED

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Saltar
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Detectar dirección del input
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Detectar si Shift está presionado
	if Input.is_action_pressed("run"):  # Nueva acción para correr
		current_speed = RUN_SPEED
	else:
		current_speed = WALK_SPEED

	# Aplicar movimiento
	if direction != Vector3.ZERO:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		velocity.z = move_toward(velocity.z, 0, WALK_SPEED)

	move_and_slide()
