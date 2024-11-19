package matm

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
	when ODIN_DEBUG {
		fmt.println("NOTE: This is run in debug mode.")
	}

	rl.InitWindow(DEBUG_WINDOW_WIDTH, DEBUG_WINDOW_HEIGHT, "Mage Against The Machine")
	rl.SetTargetFPS(DEBUG_FPS_CAP)

	main_loop: for !rl.WindowShouldClose() {

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		when ODIN_DEBUG {
			rl.DrawText("Mage Against The Machine -- test build", 0, 0, 20, {128, 128, 128, 128})
		}

		rl.EndDrawing()

	}
}
