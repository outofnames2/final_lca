extends NodeCoreComponent

var _states : Array[Color]

var _prev_cell : float
var _cell : float
var _next_cell : float
var _cells_neighborhood : String

func slot_data_process(new_rule : String) -> void:
		var new_states : Array[Color]
		for character in new_rule:
			var i = int(character)
			new_states.append(Color(i, i, i))
		_states = new_states
		#slot_data_output = self
		$"ViewNodeComponent".update_content(self)
			
func update_pixels(img : Image) -> void:
	var w := img.get_width()
	var h := img.get_height()
	for y in range(h):
		for x in range(w):
				_prev_cell = img.get_pixel(x - 1, y).r if x > 0 else 0
				_cell = img.get_pixel(x, y).r
				_next_cell = img.get_pixel(x + 1, y).r if x < w-1 else 0
				
				_cells_neighborhood = str(_prev_cell) + str(_cell) + str(_next_cell)
				if y >= h-1:
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
