shader_type canvas_item;

uniform float glow_strength = 0.6;
uniform vec4 glow_color : source_color = vec4(0.0, 0.8, 1.0, 1.0); // 青藍色

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	float glow = smoothstep(0.4, 1.0, tex_color.a) * glow_strength;
	COLOR = tex_color + glow_color * glow;
}
