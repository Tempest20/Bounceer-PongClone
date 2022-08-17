local aspectRatio = display.pixelHeight / display.pixelWidth
local width = display.pixelWidth
local height = width * aspectRatio

application = {
		content = {
			width = width,
			height = height,
			scale = "letterbox",
			fps = 60,
	}
}