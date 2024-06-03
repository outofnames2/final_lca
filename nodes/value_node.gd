extends NodeCoreComponent

func slot_data_process(txt):  print(txt + slot_data_output)

func _on_value_text_changed(new_text):
	slot_data_output = new_text
