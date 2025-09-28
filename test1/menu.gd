extends ColorRect

func _process(delta: float) -> void:
	$".".visible = Global.open_menu
	if Global.open_menu:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if Input.is_action_just_pressed("toggle_menu"):
		Global.open_menu = not Global.open_menu
