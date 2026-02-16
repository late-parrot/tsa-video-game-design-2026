shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform float amount : hint_range(0.0, 1.0) = 0.0;
uniform int max_pixel_size : hint_range(2, 64, 2) = 16;

void fragment() {
	int pixel_size = int(amount * float(max_pixel_size));
	if (pixel_size > 0) {
		vec2 base_resolution = vec2(1152.0, 648.0);
		vec2 viewport_size = 1.0 / SCREEN_PIXEL_SIZE;
		vec2 scale_factor = viewport_size / base_resolution;
		float max_scale = max(scale_factor.x, scale_factor.y);
		int effective_pixel_size = int(float(pixel_size) * max_scale);
		effective_pixel_size = effective_pixel_size / 2 * 2;

		vec2 pixel_coords = floor(FRAGCOORD.xy / float(effective_pixel_size)) * float(effective_pixel_size);
		vec2 uv = pixel_coords / viewport_size;
		COLOR = texture(SCREEN_TEXTURE, uv);
	}
}