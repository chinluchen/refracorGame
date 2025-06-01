shader_type canvas_item;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float glow = smoothstep(0.4, 0.9, tex_color.a);  // 根據透明度決定邊緣亮度
    COLOR = tex_color + vec4(0.1, 0.4, 1.0, 0.0) * glow;  // 藍色光暈效果
}
