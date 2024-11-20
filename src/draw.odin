package matm

import rl "vendor:raylib"

PortraitData :: struct {
	images: [dynamic]rl.Image,
	textures: [dynamic]rl.Texture,
}

draw_grid :: proc(count: i32) {
	for i: i32 = 0; i < count; i += 1 {
		rl.DrawLineEx({200*f32(i),0}, {200*f32(i), 200}, 1, rl.RED)
	}
}
