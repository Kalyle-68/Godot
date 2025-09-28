extends CharacterBody2D
func rot_vec(vec: Vector2, dir: float):
	return Vector2((vec.x*cos(dir*PI/180) - vec.y*sin(dir*PI/180)),
		(vec.x*sin(dir*PI/180) + vec.y*cos(dir*PI/180)))
var up_rot = 0
var rot = 0
var accel = Vector2(3072, 512)
const TRANS = 0.2
func physic_vec(vec: Vector2, add_dir):
	return rot_vec(vec, atan2(self.up_direction.y, self.up_direction.x) + PI / 2 + (add_dir * (PI/180)))
func _ready() -> void:
	pass
func is_on_rel_floor():
	if (-PI / 4 < up_rot) and (up_rot < PI / 4):
		return is_on_floor()
	if ((-PI / 4 < (up_rot - PI / 2) % PI * 2) and ((up_rot - PI / 2) % PI * 2 < PI / 4)
	 or (-PI / 4 < (up_rot + PI / 2) % PI * 2) and ((up_rot + PI / 2) % PI * 2 < PI / 4)):
		return is_on_wall()
	if (-PI / 4 < (up_rot + PI) % PI * 2) and ((up_rot + PI) % PI * 2< PI / 4):
		return is_on_ceiling()
func is_on_rel_wall():
	if ((-PI / 4 < up_rot) and (up_rot < PI / 4) or 
		(-PI / 4 < (up_rot + PI) % PI * 2) and ((up_rot + PI) % PI * 2< PI / 4)):
		return is_on_wall()
	if (-PI / 4 < (up_rot - PI / 2) % PI * 2) and ((up_rot - PI / 2) % PI * 2 < PI / 4):
		return is_on_floor() or is_on_ceiling()
	if (-PI / 4 < (up_rot + PI / 2) % PI * 2) and ((up_rot + PI / 2) % PI * 2 < PI / 4):
		return is_on_floor() or is_on_ceiling()
func is_on_rel_ceil():
	if (-PI / 4 < up_rot) and (up_rot < PI / 4):
		return is_on_ceiling()
	if ((-PI / 4 < (up_rot - PI / 2) % PI * 2) and ((up_rot - PI / 2) % PI * 2 < PI / 4)
	 or (-PI / 4 < (up_rot + PI / 2) % PI * 2) and ((up_rot + PI / 2) % PI * 2 < PI / 4)):
		return is_on_wall()
	if (-PI / 4 < (up_rot + PI) % PI * 2) and ((up_rot + PI) % PI * 2< PI / 4):
		return is_on_floor()
func _physics_process(dt: float) -> void:
	up_rot = atan2(self.up_direction.y, self.up_direction.x) + PI / 2
	if not is_on_rel_floor():
		velocity += physic_vec(get_gravity(), rot) * dt
		if (is_on_rel_wall() and not (is_on_rel_floor() and is_on_rel_ceil())
		 and velocity.y > 0 and Input.get_axis("move_left", "move_right") != 0):
			velocity.y *= 0.9
			$anim.play("slide")
			if Input.is_action_pressed("jump"):
				velocity.y -= accel.y * 1.5
				velocity.x += -Input.get_axis("move_left", "move_right") * accel.x * dt * 12
		velocity.x *= 0.95
		velocity.x += Input.get_axis("move_left", "move_right") * accel.x * 0.5 * dt
	else:
		velocity.x *= 0.85
		velocity.x += Input.get_axis("move_left", "move_right") * accel.x * dt
	if Input.is_action_pressed("jump") and is_on_rel_floor():
		velocity.y -= accel.y
	if not is_on_rel_floor():
		if velocity.y < 0:
			$anim.play("jump_up")
		if velocity.y > 0 and !(is_on_rel_wall() and not (is_on_rel_floor() and is_on_rel_ceil())
			and velocity.y > 0 and Input.get_axis("move_left", "move_right") != 0):
			$anim.play("jump_down")
	elif Input.get_axis("move_left", "move_right") != 0:
		$anim.play("run_walk")
	else:
		$anim.play("idle")
	if velocity.x > 0:
		$anim.flip_h = false
	if velocity.x < 0:
		$anim.flip_h = true
	if Globals.hearts <= 4:
		$Camera2D/heart1.modulate[3] = TRANS
	if Globals.hearts <= 3:
		$Camera2D/heart2.modulate[3] = TRANS
	if Globals.hearts <= 2:
		$Camera2D/heart3.modulate[3] = TRANS
	if Globals.hearts <= 1:
		$Camera2D/heart4.modulate[3] = TRANS
	if Globals.hearts == 0:
		$Camera2D/heart5.modulate[3] = TRANS
	move_and_slide()
