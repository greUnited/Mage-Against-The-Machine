package matm

import "core:fmt"
import rl "vendor:raylib"
import "vendor:raylib/rlgl"

DEFAULT_GRID_SIZE :: 200

main :: proc() {
	when ODIN_DEBUG {
		fmt.println("INFO: This is run in debug mode.")
		rl.SetTraceLogLevel(.WARNING)
	}

	rl.InitWindow(DEBUG_WINDOW_WIDTH, DEBUG_WINDOW_HEIGHT, "Mage Against The Machine")
	rl.SetTargetFPS(DEBUG_FPS_CAP)

	player_camera: rl.Camera2D
	player_camera.offset = {DEBUG_WINDOW_WIDTH / 2, DEBUG_WINDOW_HEIGHT / 2}
	// player_camera.target = {DEBUG_WINDOW_WIDTH / 2, DEBUG_WINDOW_HEIGHT / 2}
	player_camera.zoom = 1.0

	test_map_image := rl.LoadImage("assets/test_map.png")
	test_map_tex := rl.LoadTextureFromImage(test_map_image)

	test_token_image := rl.LoadImage("assets/ph_portrait1.png")
	test_token_tex := rl.LoadTextureFromImage(test_token_image)

	main_loop: for !rl.WindowShouldClose() {

		if rl.IsKeyDown(.LEFT_CONTROL) && rl.IsMouseButtonDown(.LEFT) {
			player_camera.target -= rl.GetMouseDelta() / player_camera.zoom
		}

		player_camera.zoom += rl.GetMouseWheelMove() * rl.GetFrameTime()
		fmt.println(player_camera.zoom)



		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		when ODIN_DEBUG {
			rl.DrawText("Mage Against The Machine -- test build", 0, 0, 20, {128, 128, 128, 128})
		}

		rl.BeginMode2D(player_camera)

		// rl.DrawTexture(test_map_tex, 0, 0, rl.RAYWHITE)
		// rl.DrawTexture(test_token_tex, 0, 0, rl.RAYWHITE)
		draw_grid(20)

		rl.EndMode2D()

		rl.EndDrawing()

	}
}
