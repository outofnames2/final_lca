extends Node
class_name ElemenCA

var rules : String : set = set_rules
var _states : Array[Color]

var _prev_cell : float
var _cell : float
var _next_cell : float

var _l_bound : int
var _r_bound : int
var _d_bound : int
var _cells_neighborhood : String

func update_cells(view : DrawViewport) -> void:
	var img := view.img
	for y in range(img.get_height()):
		_d_bound = int(y < img.get_height())	
		for x in range(img.get_width()):
				_l_bound = int(x != 0)
				_r_bound = int(x != img.get_width()-1)
				_prev_cell = img.get_pixel(x - 1 * _l_bound, y).r * _l_bound
				_cell = img.get_pixel(x, y).r
				_next_cell = img.get_pixel(x  + 1 * _r_bound, y).r * _r_bound
				
				_cells_neighborhood = str(_prev_cell) + str(_cell) + str(_next_cell)
				if y >= img.get_height()-1:
					break
				match _cells_neighborhood:
					"111":
						img.set_pixel(x, y + 1, _states[0])
					"110":
						img.set_pixel(x, y + 1, _states[1])
					"101":
						img.set_pixel(x, y + 1, _states[2])
					"100":
						img.set_pixel(x, y + 1, _states[3])
					"011":
						img.set_pixel(x, y + 1, _states[4])
					"010":
						img.set_pixel(x, y + 1, _states[5])
					"001":
						img.set_pixel(x, y + 1, _states[6])
					"000":
						img.set_pixel(x, y + 1, _states[7])
	view.content.texture = ImageTexture.create_from_image(view.img)

func set_rules(new_rules: String) -> void:
	var new_states : Array[Color]
	for rule in new_rules:
		new_states.append(Color(int(rule), int(rule), int(rule)))
	_states = new_states
	update_cells(%DrawViewport)
		
