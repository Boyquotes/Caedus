extends CharacterBody2D


var speed = 2100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var distance = position.distance_to(mouse_pos)
	
	if distance < 75:
		var angle = position.angle_to_point(mouse_pos) + 180
		var direction = Vector2(cos(angle), sin(angle))
		velocity = direction * speed * delta
		move_and_slide()
