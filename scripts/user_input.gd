extends LineEdit

@onready var view = %DrawViewport
func _on_text_submitted(txt: String) -> void:
	if txt.length() < 8:
		self.clear()
	else:
		view.rules = txt
