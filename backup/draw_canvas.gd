extends TextureRect
class_name DrawCanvas

var _mouse_is_in : bool
var _click_pos : Vector2
@export_range(2, 64, 2) var width : int = 64
@warning_ignore("integer_division")
var height : int = width / 2
var img : Image = Image.create(width, height, false, Image.FORMAT_RGB8)

func _ready():
	img.fill(Color.BLACK)
	#img.set_pixel(width*0.5, 0, Color.WHITE)
	self.texture = ImageTexture.create_from_image(img)
	
func _input(_event: InputEvent) -> void:
	if not _mouse_is_in:
		return
		
	_click_pos = get_local_mouse_position() / Vector2(get_viewport().get_visible_rect().size)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		@warning_ignore("narrowing_conversion")
		img.set_pixel(_click_pos.x * width, _click_pos.y * height, Color.WHITE)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		@warning_ignore("narrowing_conversion")
		img.set_pixel(_click_pos.x * width, _click_pos.y * height, Color.BLACK)
		
	self.texture = ImageTexture.create_from_image(img)
	
func _on_mouse_entered():
	_mouse_is_in = true

func _on_mouse_exited():
	_mouse_is_in = false
