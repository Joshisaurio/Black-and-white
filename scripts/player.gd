extends CharacterBody2D


const SPEED : float = 450.0
const JUMP_VELOCITY : float = -890.0
const PAD_VELOCITY : float = -1250.0

var black : bool = true
var death_effect : PackedScene = preload("res://scenes/deathparticles.tscn")
var dead : bool = false

var respawn_point : Vector2 = Vector2(160, -100)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY   
		
	if $JumpBox.has_overlapping_bodies():
		velocity.y = PAD_VELOCITY
	
	if Input.is_action_just_pressed("switch") and !$Colorbox.has_overlapping_bodies():
		black = not black
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if black:
		collision_mask = 2
		modulate = "000000"
	else:
		collision_mask = 1
		modulate = "ffffff"
		
	if $Hurtbox.has_overlapping_bodies() and not dead:
		dead = true
		var particles : GPUParticles2D = death_effect.instantiate()
		particles.emitting = true
		particles.position = position
		particles.modulate = modulate
		get_parent().add_child(particles)
		$RespawnTimer.start()
		hide()
	
	if not $Hurtbox.has_overlapping_bodies():
		if dead:
			black = true
			dead = false
		show()
		

	move_and_slide()

func _on_respawn_timer_timeout() -> void:
	position = respawn_point
	black = true
	
