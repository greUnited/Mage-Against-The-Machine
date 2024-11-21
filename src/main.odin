package matm

import "core:fmt"
import rl "vendor:raylib"
import "vendor:raylib/rlgl"

DEFAULT_GRID_SIZE :: 200

vec2 :: [2]f32

mouse_world_pos_get :: proc(camera: ^rl.Camera2D) -> vec2 {
	return (rl.GetMousePosition() - camera.offset) / camera.zoom + camera.target
}

main :: proc() {
	when ODIN_DEBUG {
		fmt.println("INFO: This is run in debug mode.")
		rl.SetTraceLogLevel(.WARNING)
	}

	rl.InitWindow(DEBUG_WINDOW_WIDTH, DEBUG_WINDOW_HEIGHT, "Mage Against The Machine")
	rl.SetTargetFPS(DEBUG_FPS_CAP)

	player_camera: rl.Camera2D
	player_camera.offset = {DEBUG_WINDOW_WIDTH / 2, DEBUG_WINDOW_HEIGHT / 2}
	player_camera.target = {DEBUG_WINDOW_WIDTH / 2, DEBUG_WINDOW_HEIGHT / 2}
	player_camera.zoom = 1.0

	tmap_img := rl.LoadImage("assets/map_ruined_temple.png")
	tmap_tex := rl.LoadTextureFromImage(tmap_img)

	test_textures: [5]rl.Texture
	test_token_image := rl.LoadImage("assets/ph_portrait1.png")
	// test_token_tex := rl.LoadTextureFromImage(test_token_image)
	test_textures[0] = rl.LoadTextureFromImage(test_token_image)
	test_textures[1] = rl.LoadTextureFromImage(test_token_image)
	test_textures[2] = rl.LoadTextureFromImage(test_token_image)
	test_textures[3] = rl.LoadTextureFromImage(test_token_image)
	test_textures[4] = rl.LoadTextureFromImage(test_token_image)
	test_textures_pos := [5]vec2{
		{0, 0},
		{400, 0},
		{800, 0},
		{1200, 0},
		{1600, 0},
	}

	main_loop: for !rl.WindowShouldClose() {

		if rl.IsKeyDown(.LEFT_CONTROL) && rl.IsMouseButtonDown(.LEFT) {
			player_camera.target -= rl.GetMouseDelta() / player_camera.zoom
		}

		player_camera.zoom += rl.GetMouseWheelMove() * rl.GetFrameTime()



		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		when ODIN_DEBUG {
			rl.DrawText("Mage Against The Machine -- test build", 0, 0, 20, {128, 128, 128, 128})
		}

		rl.BeginMode2D(player_camera)

		// Let's try mouse world position collision checking
		mouse_pos := mouse_world_pos_get(&player_camera)
		for i in 0..<len(test_textures) {
			if (mouse_pos.x >= test_textures_pos[i].x && 
				mouse_pos.x <= (test_textures_pos[i].x + f32(test_textures[i].width)) &&
				mouse_pos.y >= test_textures_pos[i].y && 
				mouse_pos.y <= (test_textures_pos[i].y + f32(test_textures[i].height)))
			{
				rl.DrawTextureV(test_textures[i], test_textures_pos[i], rl.GREEN);
			}
			else {
				rl.DrawTextureV(test_textures[i], test_textures_pos[i], rl.RAYWHITE);
			}
		}

		rl.EndMode2D()

		rl.EndDrawing()

	}
}
