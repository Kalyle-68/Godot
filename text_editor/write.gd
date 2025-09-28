extends Control
var path
func save_to_file(path, content):
	print("Save " + content + " to " + path)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(content)
func load_from_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return content
func handle_label(time, text):
	$Timer.wait_time = 1
	$state.text = text
	$Timer.start()
	$state.visible = true
	
func _ready() -> void:
	$path/TextEdit.text = "C:/Users/Public/Documents/Code/Godot/save_game.txt"
	path = $path/TextEdit.text
	$code/CodeEdit.text = load_from_file(path)
func _process(_dt: float) -> void:
	if Input.is_action_just_pressed("save"):
		save_to_file(path, $code/CodeEdit.text)
		handle_label(1, "Saving...")
func _time_end() -> void:
	$state.visible = false
