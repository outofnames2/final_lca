extends Node
class_name ElemenCA

@export var drawing : DrawCanvas

var _prev_cell : float
var _cell : float
var _next_cell : float
var _rules : Array[Color]
var _l_bound : int
var _r_bound : int
var _d_bound : int
var _cells_neighborhood : String

func display():
	#_img.set_pixel(width*0.5, 0, Color.WHITE)
	for y in range(drawing.height):
		_d_bound = int(y < drawing.height)	
		for x in range(drawing.width):
				_l_bound = int(x != 0)
				_r_bound = int(x != drawing.width-1)
				_prev_cell = drawing.img.get_pixel(x - 1 * _l_bound, y).r * _l_bound
				_cell = drawing.img.get_pixel(x, y).r
				_next_cell = drawing.img.get_pixel(x  + 1 * _r_bound, y).r * _r_bound
				
				_cells_neighborhood = str(_prev_cell) + str(_cell) + str(_next_cell)
				if y >= drawing.height-1:
					break
				match _cells_neighborhood:
					"111":
						drawing.img.set_pixel(x, y + 1, _rules[0])
					"110":
						drawing.img.set_pixel(x, y + 1, _rules[1])
					"101":
						drawing.img.set_pixel(x, y + 1, _rules[2])
					"100":
						drawing.img.set_pixel(x, y + 1, _rules[3])
					"011":
						drawing.img.set_pixel(x, y + 1, _rules[4])
					"010":
						drawing.img.set_pixel(x, y + 1, _rules[5])
					"001":
						drawing.img.set_pixel(x, y + 1, _rules[6])
					"000":
						drawing.img.set_pixel(x, y + 1, _rules[7])
	drawing.texture = ImageTexture.create_from_image(drawing.img)

func set_rules(rules: String) -> void:
	_rules.clear()
	for rule in rules:
		var state = Color(int(rule), int(rule), int(rule))
		_rules.append(state)
	
