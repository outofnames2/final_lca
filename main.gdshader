shader_type canvas_item;

uniform float test:hint_range(0, 1, 0.01);
uniform float[8] rules;
void fragment() {
	vec2 px = TEXTURE_PIXEL_SIZE;
	vec4 cell = texelFetch(TEXTURE, ivec2(UV/px), 0);
	//vec4 bcell = texelFetch(TEXTURE, ivec2(vec2(UV.x - test * px.x, UV.y)/px), 0);
	vec2 fgrid = floor(UV / px) * px;
	//if (cell.x - bcell.x > 0.) {COLOR = vec4(0);}
	if (fgrid.x < test && fgrid.y == 0.) {COLOR.rgb = vec3(0);}

	
}