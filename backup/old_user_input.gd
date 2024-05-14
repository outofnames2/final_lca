extends LineEdit

@export var text_receiver: ElemenCA
func _on_text_submitted(txt: String) -> void:
	if txt.length() < 8:
		self.clear()
	else:
		text_receiver.set_rules(txt)
		text_receiver.display()
