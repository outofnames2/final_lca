extends SubViewportContainer
class_name DrawViewport

var _mouse_is_in : bool
var img : Image
var rules : String : set = set_rules
func set_rules(new_rules : String) -> void:
	algorithm.rules = new_rules
	rules = new_rules

@onready var content : TextureRect = $SubViewport/Content

@export var algorithm : ElemenCA
@export_range(0.01, 1, 0.01) var resolution : float = 0.25: set = _set_resolution
func _set_resolution(new_res: float):
	if not is_node_ready():
		return
	var s = size * new_res
	img = Image.create(s.x, s.y, false, Image.FORMAT_RGB8)
	resolution = new_res
	
func _ready():
	resolution = 0.25
	img.fill(Color.BLACK)
	content.texture = ImageTexture.create_from_image(img)
	
func _gui_input(event: InputEvent) -> void:
	if not _mouse_is_in:
		return
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		@warning_ignore("narrowing_conversion")
		img.set_pixelv(event.position * resolution, Color.WHITE)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		@warning_ignore("narrowing_conversion")
		img.set_pixelv(event.position * resolution, Color.BLACK)
	elif Input.is_action_just_released("ui_select") and rules != "":
		algorithm.update_cells(self)
		
	content.texture = ImageTexture.create_from_image(img)

func _on_mouse_entered():
	_mouse_is_in = true

func _on_mouse_exited():
	_mouse_is_in = false
	

func _on_resized():
	_set_resolution(resolution)
