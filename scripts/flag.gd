extends Area2D

var activated : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if has_overlapping_bodies() and not activated:
		activated = true
		get_tree().get_first_node_in_group("player").respawn_point = position
		#print(get_overlapping_bodies())
		$GPUParticles2D.emitting = true
	elif get_tree().get_first_node_in_group("player").respawn_point != position:
		activated = false
	
	if !activated:
		modulate = get_tree().get_first_node_in_group("player").modulate
	else:
		modulate = "009000" if get_tree().get_first_node_in_group("player").black else "00c400"
