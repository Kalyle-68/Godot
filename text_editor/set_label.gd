extends TextEdit

var label: RichTextLabel
func _ready() -> void:
	label = get_parent().get_child(0)
func _process(_dt: float) -> void:
	label.text = self.text
	print(self.text)
