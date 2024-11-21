package matm

import rl "vendor:raylib"

PortraitData :: struct {
	images: [dynamic]rl.Image,
	textures: [dynamic]rl.Texture,
}

grid_draw :: proc(count: i32) {
	for i: i32 = 0; i < count; i += 1 {
		rl.DrawLineV({200*f32(i),0}, {200*f32(i), 200}, rl.RED)
	}
}
