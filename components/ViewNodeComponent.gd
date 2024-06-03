extends SubViewportContainer
class_name ViewNodeComponent

var input : Image
@export var resolution : Vector2i = Vector2i(100, 100): set = _set_resolution
@export var ratio : float = 1
@onready var content : TextureRect = $SubViewport/Content

func _ready():
	size = resolution
	content.texture = ImageTexture.create_from_image(input)
		
func _set_resolution(new_res: Vector2i):
	input = Image.create(new_res.x * ratio, new_res.y * ratio, false, Image.FORMAT_RGB8)
	input.fill(Color.BLACK)
	input.set_pixel(new_res.x/2 * ratio, 0, Color.WHITE)
	resolution = new_res

# El tamaño del subviewport se actualiza al recibir input
# por ende hay que reevaluar la resolucion
# para que el input del mouse siga siendo preciso
func _on_resized():
	resolution = resolution

func update_content(algo):
	algo.update_pixels(input)
	content.texture = ImageTexture.create_from_image(input)
	
