extends ViewNodeComponent
class_name DrawViewNodeComponent

var _mouse_is_in : bool
#var rules : String : set = set_rules
#func set_rules(new_rules : String) -> void:
	#algorithm.rules = new_rules
	#rules = new_rules

#@export var algorithm : ElemenCA

func _gui_input(event: InputEvent) -> void:
	if not _mouse_is_in:
		return
		
	# la resolucion del subviewport y la textura son las mismas
	# en caso de cambiar esto hay que:
	# mapear la posicion a la resolucion de la textura
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		input.set_pixelv(event.position * ratio, Color.WHITE)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		input.set_pixelv(event.position * ratio, Color.BLACK)
	elif Input.is_action_just_released("ui_select") or Input.is_action_just_released("ui_cancel"):
		# TODO: tendria que actualizar su contenido dependiendo de los datos que le llegan
		# y tambien actualizar los datos que manda 
		# (es un canvas que puede ser usado de input, output o ambas a la vez)
		pass
		#algorithm.update_cells(self)
	content.texture = ImageTexture.create_from_image(input)

func _on_mouse_entered():
	_mouse_is_in = true

func _on_mouse_exited():
	_mouse_is_in = false
