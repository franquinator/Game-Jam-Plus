extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	if Input.is_action_pressed("derecha"):
		direction.x += 1
	if Input.is_action_pressed("izquierda"):
		direction.x -= 1
	if Input.is_action_pressed("abajo"):
		direction.z += 1
	if Input.is_action_pressed("arriba"):
		direction.z -= 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
		
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()