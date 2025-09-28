extends Node

var open_menu = false
@onready var console: RichTextLabel = get_tree().get_first_node_in_group("console")

func debug_print(msg):
	console.text = str(msg)
