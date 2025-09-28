extends CharacterBody3D


const SPEED = 3.5
var mouse_position = Vector2(0, 0)
var WIN_DIM = Vector2(0, 0)
var mouse_lock_pos
@onready var menu: ColorRect = get_tree().get_first_node_in_group("pause_menu")
func  _ready() -> void:
	WIN_DIM = get_viewport().size
	mouse_lock_pos = WIN_DIM
	mouse_lock_pos.x /= 2
	mouse_lock_pos.y /= 2

func _physics_process(delta: float) -> void:
	var sensitivtiy = menu.get_node("sens").value
	if not Global.open_menu:
		mouse_position += Vector2(-(get_viewport().get_mouse_position().x / WIN_DIM.x - 0.5)*sensitivtiy,
			-(get_viewport().get_mouse_position().y / WIN_DIM.y - 0.5)*sensitivtiy)
		get_viewport().warp_mouse(mouse_lock_pos)
		$cam.rotation = Vector3(mouse_position.y, mouse_position.x, $cam.rotation.z)
		if not is_on_floor():
			velocity += get_gravity() * delta
	var input_dir := Input.get_vector("strafe_left", "strafe_right", "foward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and not Global.open_menu:
		var move_dir = max(min(direction.z-direction.x, 1), -1)
		if direction.x > 0:
			$cam.rotation.y += PI/2
		elif direction.x < 0:
			$cam.rotation.y -= PI/2
		velocity.x = (move_dir * sin($cam.rotation.y))*SPEED
		velocity.z = (move_dir * cos($cam.rotation.y))*SPEED
		if direction.x > 0:
			$cam.rotation.y -= PI/2
		elif direction.x < 0:
			$cam.rotation.y += PI/2
	else:
		velocity.x *= 0.65
		velocity.z *= 0.65
	if not Global.open_menu:
		move_and_slide()
