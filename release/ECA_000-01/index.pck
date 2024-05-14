GDPC                �                                                                         X   res://.godot/exported/133200997/export-23d8c8b20bab0ee57350b373b372e3a4-draw_canvas.scn 0      )      ތ� .��1�~    P   res://.godot/exported/133200997/export-3ad5c15c4f3250da0cc7c1af1770d85f-main.scn@$      �      +~m��O���1'�u��    T   res://.godot/exported/133200997/export-8453bbce8a73163edbf0563d7d509371-old_main.scn`      b
      ����:�*wq���l    X   res://.godot/exported/133200997/export-f252fe6607e4db12ae563301e5d146ea-elemen_ca.scn   �!      u      �-,<����r�DX��    \   res://.godot/exported/133200997/export-fe0c5c04b4c32b2f547d5c1e3235de23-draw_viewport.scn   �            ȝ% R�3Ox%�Os    ,   res://.godot/global_script_class_cache.cfg  J      �      ���M:?z��D�P��    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexP8            ：Qt�E�cO���       res://.godot/uid_cache.bin  pO      �      @�02XK|�%�?��rl       res://backup/draw_canvas.gd         /      U�G��T��DQ���    $   res://backup/draw_canvas.tscn.remap �G      h       [`�	��:�K
�gp       res://backup/old_ElemenCA.gd`	      �      ���/�L���6���O        res://backup/old_main.tscn.remapPH      e       ���]����b�|;6��        res://backup/old_user_input.gd  �      �       ����<�o��G\��)#       res://icon.svg  �K      �      k����X3Y���f       res://icon.svg.import   pE      �       N����σ��2���S       res://main.gdshader 0F      �      ��5��²k]/�c[       res://project.binary Q      �      ��"��xF׻�6ƌU�    (   res://scenes/draw_viewport.tscn.remap   �H      j       ��[��].p�΋�    $   res://scenes/elemen_ca.tscn.remap   0I      f       ȨbK�xL�t�f��J       res://scenes/main.tscn.remap�I      a       
��������S8z�s        res://scripts/DrawViewport.gd   0,      h      ��3��%�XpEB����0       res://scripts/ElemenCA.gd   �1      �      ��J�� m����n��N       res://scripts/user_input.gd �7      �       	�s�\W��arU�ʝ                extends TextureRect
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
 RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    shader    shader_parameter/test    shader_parameter/rules    script    image 	   _bundled       Shader    res://main.gdshader ��������   Script    res://backup/draw_canvas.gd ��������      local://ShaderMaterial_ydd7u �         local://ImageTexture_rwvu0 ?         local://PackedScene_cu1am \         ShaderMaterial                              !                    �?  �?  �?  �?             ImageTexture             PackedScene          	         names "         DrawCanvas    texture_filter 	   material    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    size_flags_horizontal    size_flags_vertical    texture    expand_mode    stretch_mode    script    TextureRect    	   variants                            �?                                          node_count             nodes        ��������       ����                                                    	      
                            conn_count              conns               node_paths              editable_instances              version             RSRC       extends Node
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
	
           RSRC                    PackedScene            ��������                                                  ..    SubViewportContainer    SubViewport    DrawCanvas    CA    resource_local_to_scene    resource_name    script/source    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom    script 	   _bundled       Script    res://backup/old_user_input.gd ��������   PackedScene    res://backup/draw_canvas.tscn ��e���@   PackedScene    res://scenes/elemen_ca.tscn ��]�M�T      local://GDScript_6vay8 �         local://StyleBoxEmpty_eesuf �         local://StyleBoxEmpty_udthv          local://PackedScene_kdxkt %      	   GDScript             extends VBoxContainer
    StyleBoxEmpty             StyleBoxEmpty             PackedScene          	         names "   (      Control    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    VBoxContainer    anchor_left    anchor_top    offset_left    offset_top    offset_right    offset_bottom    script 	   LineEdit    theme_override_styles/normal    theme_override_styles/focus    placeholder_text    max_length    context_menu_enabled    text_receiver    SubViewportContainer    size_flags_horizontal    size_flags_vertical    SubViewport    disable_3d    handle_input_locally    size    render_target_update_mode    DrawCanvas    unique_name_in_owner    expand_mode    CA    _on_text_submitted    text_submitted    _on_mouse_entered    mouse_entered    _on_mouse_exited    mouse_exited    	   variants                        �?                        ?    �@�    �P�    �@C    �PC                                  Escribe aqui.                                                     -   @  �                                 node_count             nodes     y   ��������        ����                                                          ����                     	                  
               	      
                                      ����                                               @                    ����                                      ����                                      ���                                 ���!                    conn_count             conns              #   "                    %   $                    '   &                    node_paths              editable_instances              version             RSRC              extends LineEdit

@export var text_receiver: ElemenCA
func _on_text_submitted(txt: String) -> void:
	if txt.length() < 8:
		self.clear()
	else:
		text_receiver.set_rules(txt)
		text_receiver.display()
       RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    shader    shader_parameter/test    shader_parameter/rules    script    image 	   _bundled       Script    res://scripts/DrawViewport.gd ��������   Shader    res://main.gdshader ��������      local://ShaderMaterial_ydd7u �         local://ImageTexture_rwvu0 A         local://PackedScene_p6xmf ^         ShaderMaterial                             !                    �?  �?  �?  �?             ImageTexture             PackedScene          	         names "         DrawViewport    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    size_flags_vertical    stretch    script    resolution    SubViewportContainer    SubViewport    disable_3d    handle_input_locally    size    render_target_update_mode    Content    texture_filter 	   material    anchors_preset    size_flags_horizontal    texture    stretch_mode    TextureRect    _on_mouse_entered    mouse_entered    _on_mouse_exited    mouse_exited    	   variants            �?                            )   {�G�z�?       -   �  �                                                   node_count             nodes     C   ��������	       ����                                                                 
   
   ����                                            ����      	      
                                                                     conn_count             conns                                                                node_paths              editable_instances              version             RSRC   RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://scripts/ElemenCA.gd ��������      local://PackedScene_qhfsr          PackedScene          	         names "      	   ElemenCA    script    Node    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC           RSRC                    PackedScene            ��������                                            	      CA    resource_local_to_scene    resource_name    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom    script 	   _bundled       Script    res://scripts/user_input.gd ��������   PackedScene     res://scenes/draw_viewport.tscn M0�\�=   PackedScene    res://scenes/elemen_ca.tscn ��]�M�T      local://StyleBoxEmpty_eesuf @         local://StyleBoxEmpty_udthv ^         local://PackedScene_ym6l7 |         StyleBoxEmpty             StyleBoxEmpty             PackedScene          	         names "         Control    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    VBoxContainer    anchor_left    anchor_top    offset_left    offset_top    offset_right    offset_bottom 	   LineEdit    theme_override_styles/normal    theme_override_styles/focus    placeholder_text    max_length    context_menu_enabled    script    DrawViewport    unique_name_in_owner 
   algorithm    resolution    CA    _on_text_submitted    text_submitted    	   variants                        �?                        ?    �@�    �P�    �@C    �PC                         Escribe aqui.                                           )   q=
ףp�?               node_count             nodes     ]   ��������        ����                                                          ����                     	                  
               	      
                                ����                                                        ���                       @                    ���                    conn_count             conns                                     node_paths              editable_instances              version             RSRC      extends SubViewportContainer
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
	
func _input(_event: InputEvent) -> void:
	if not _mouse_is_in:
		return
		
	var _pos = get_local_mouse_position()
	#print(content.size, " ", _pos, " ")
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		@warning_ignore("narrowing_conversion")
		img.set_pixelv(_pos * resolution, Color.WHITE)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		@warning_ignore("narrowing_conversion")
		img.set_pixelv(_pos * resolution, Color.BLACK)
	elif Input.is_action_just_released("ui_select") and rules != "":
		algorithm.update_cells(self)
		
	content.texture = ImageTexture.create_from_image(img)

func _on_mouse_entered():
	_mouse_is_in = true

func _on_mouse_exited():
	_mouse_is_in = false
        extends Node
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
		
     extends LineEdit

@onready var view = %DrawViewport
func _on_text_submitted(txt: String) -> void:
	if txt.length() < 8:
		self.clear()
	else:
		view.rules = txt
               GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://6rt07oangqx"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
  shader_type canvas_item;

uniform float test:hint_range(0, 1, 0.01);
uniform float[8] rules;
void fragment() {
	vec2 px = TEXTURE_PIXEL_SIZE;
	vec4 cell = texelFetch(TEXTURE, ivec2(UV/px), 0);
	//vec4 bcell = texelFetch(TEXTURE, ivec2(vec2(UV.x - test * px.x, UV.y)/px), 0);
	vec2 fgrid = floor(UV / px) * px;
	//if (cell.x - bcell.x > 0.) {COLOR = vec4(0);}
	if (fgrid.x < test && fgrid.y == 0.) {COLOR.rgb = vec3(0);}

	
}        [remap]

path="res://.godot/exported/133200997/export-23d8c8b20bab0ee57350b373b372e3a4-draw_canvas.scn"
        [remap]

path="res://.godot/exported/133200997/export-8453bbce8a73163edbf0563d7d509371-old_main.scn"
           [remap]

path="res://.godot/exported/133200997/export-fe0c5c04b4c32b2f547d5c1e3235de23-draw_viewport.scn"
      [remap]

path="res://.godot/exported/133200997/export-f252fe6607e4db12ae563301e5d146ea-elemen_ca.scn"
          [remap]

path="res://.godot/exported/133200997/export-3ad5c15c4f3250da0cc7c1af1770d85f-main.scn"
               list=Array[Dictionary]([{
"base": &"TextureRect",
"class": &"DrawCanvas",
"icon": "",
"language": &"GDScript",
"path": "res://backup/draw_canvas.gd"
}, {
"base": &"SubViewportContainer",
"class": &"DrawViewport",
"icon": "",
"language": &"GDScript",
"path": "res://scripts/DrawViewport.gd"
}, {
"base": &"Node",
"class": &"ElemenCA",
"icon": "",
"language": &"GDScript",
"path": "res://scripts/ElemenCA.gd"
}])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              E�KF� 5   res://scenes/AMONGUS.tscn��]�M�T#   res://scenes/cellular_automata.tscn��e���@   res://scenes/draw_canvas.tscnM0�\�=   res://scenes/draw_viewport.tscn��o��P   res://scenes/main.tscnw�c��&�    res://icon.svg��e���@   res://backup/draw_canvas.tscn��o��P   res://backup/main.tscn��o��P   res://backup/old_main.tscn��]�M�T   res://scenes/elemen_ca.tscnE�KF� 5   res://scenes/main.tscn              ECFG      application/config/name          cellular_automata_lca      application/run/main_scene          res://scenes/main.tscn     application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg  #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility4   rendering/textures/vram_compression/import_etc2_astc             